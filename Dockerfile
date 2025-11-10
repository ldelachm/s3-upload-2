FROM amazon/aws-cli:2.28.22

COPY . .

# Accept AWS credentials as build arguments
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_SESSION_TOKEN
ARG AWS_DEFAULT_REGION

# Set them as environment variables
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN
ENV AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION


# Debug commands to check credentials
RUN echo "=== Checking AWS Credentials ==="
RUN echo "AWS_ACCESS_KEY_ID exists: $([ -n "$AWS_ACCESS_KEY_ID" ] && echo 'YES' || echo 'NO')"
RUN echo "AWS_SECRET_ACCESS_KEY exists: $([ -n "$AWS_SECRET_ACCESS_KEY" ] && echo 'YES' || echo 'NO')"
RUN echo "AWS_SESSION_TOKEN exists: $([ -n "$AWS_SESSION_TOKEN" ] && echo 'YES' || echo 'NO')"
RUN echo "AWS_DEFAULT_REGION: $AWS_DEFAULT_REGION"

RUN aws sts get-caller-identity

RUN aws s3 cp requirements.txt s3://codebuild-dockerserver-artifacts-re/folder/
