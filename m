From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 08:11:23 -0600
Subject: [PATCH v7 1/4] dt/bindings: add bindings for optee
In-Reply-To: <1454318140-7962-2-git-send-email-jens.wiklander@linaro.org>
References: <1454318140-7962-1-git-send-email-jens.wiklander@linaro.org>
 <1454318140-7962-2-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20160201141123.GA7792@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 10:15:37AM +0100, Jens Wiklander wrote:
> Introduces linaro prefix and adds bindings for ARM TrustZone based OP-TEE
> implementation.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../bindings/arm/firmware/linaro,optee-tz.txt      | 31 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt

Acked-by: Rob Herring <robh@kernel.org>
