FROM ruby

RUN apt-get update -y

RUN apt-get -y install --no-install-recommends \
    curl \
    python \
    openjdk-8-jdk \
    unzip \
    zip \
    git \
    build-essential \
    file \
    ssh

ENV SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip" \
    ANDROID_HOME="/usr/local/android-sdk" \
    ANDROID_VERSION=27 \
    ANDROID_BUILD_TOOLS_VERSION=27.0.2 \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LANG="en_US.UTF-8"

RUN mkdir "$ANDROID_HOME" .android \
    && cd "$ANDROID_HOME" \
    && curl -o sdk.zip $SDK_URL \
    && unzip sdk.zip \
    && rm sdk.zip \
    && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

ENV PATH="$PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

RUN sdkmanager --update
RUN sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools"

RUN gem install fastlane; mkdir /application
WORKDIR /application


