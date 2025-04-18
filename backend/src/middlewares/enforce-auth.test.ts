import { Request, Response } from "express";
import { enforceAuth } from "./enforce-auth";
import { StatusCodes } from "http-status-codes";
import { sign } from "jsonwebtoken";
import config from "config";
import AppError from "../errors/app-error";

describe("enforce-auth middleware tests", () => {
  test("calls next with a 401 error when no authorization header is provided", () => {
    const request = { headers: {} } as Request;
    const response = {} as Response;
    const next = jest.fn();

    enforceAuth(request, response, next);

    expect(next).toHaveBeenCalledTimes(1);
    const error = next.mock.calls[0][0];
    expect(error).toBeInstanceOf(AppError);
    expect(error.statusCode).toBe(StatusCodes.UNAUTHORIZED);  // Correcting to statusCode
    expect(error.message).toBe("Missing authorization header");
  });

  test("calls next with a 401 error when no space between Bearer and token", () => {
    const request = {
      headers: {
        authorization: "Bearer123",  // No space between Bearer and token
      },
    } as Request;
    const response = {} as Response;
    const next = jest.fn();

    enforceAuth(request, response, next);

    expect(next).toHaveBeenCalledTimes(1);
    const error = next.mock.calls[0][0];
    expect(error).toBeInstanceOf(AppError);
    expect(error.statusCode).toBe(StatusCodes.UNAUTHORIZED);  // Correcting to statusCode
    expect(error.message).toBe("bad authorization header");
  });

  test("calls next with a 401 error when Bearer keyword is misspelled", () => {
    const request = {
      headers: {
        authorization: "Beaerer 123",  // Misspelled 'Bearer'
      },
    } as Request;
    const response = {} as Response;
    const next = jest.fn();

    enforceAuth(request, response, next);

    expect(next).toHaveBeenCalledTimes(1);
    const error = next.mock.calls[0][0];
    expect(error).toBeInstanceOf(AppError);
    expect(error.statusCode).toBe(StatusCodes.UNAUTHORIZED);  // Correcting to statusCode
    expect(error.message).toBe("bad authorization header");
  });

  test("success when all is valid", () => {
    const jwt = sign({}, config.get<string>("app.jwtSecret"));
    const request = {
      headers: {
        authorization: `Bearer ${jwt}`,  // Correct header format
      },
    } as Request;
    const response = {} as Response;
    const next = jest.fn();

    enforceAuth(request, response, next);

    expect(next).toHaveBeenCalledTimes(1);
    expect(next.mock.calls[0][0]).toBeUndefined();  // No error should be passed to next
  });
});
