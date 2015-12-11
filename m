From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 11 Dec 2015 15:14:12 -0800
Subject: [PATCH 2/3] arm64: dts: apq8016-sbc: add label properties for
 UART, I2C, and SPI
In-Reply-To: <1449782473-20880-3-git-send-email-robh@kernel.org> (Rob
 Herring's message of "Thu, 10 Dec 2015 15:21:12 -0600")
References: <1449782473-20880-1-git-send-email-robh@kernel.org>
 <1449782473-20880-3-git-send-email-robh@kernel.org>
Message-ID: <7hlh90fuij.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> Add label properties to provide a way to identify UART, I2C and SPI
> ports based on their connector names. This follows naming convention in
> 96boards CE spec. Ports without external connections are not labelled.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Andy Gross <agross@codeaurora.org>

Acked-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>

Tested this on my db410c (along with script from cover letter) and it
works great.

Kevin
