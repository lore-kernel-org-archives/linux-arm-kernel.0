From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Feb 2014 08:38:56 +0000
Subject: [PATCH v4 8/8] devicetree: bindings: Document PM8921/8058 PMICs
In-Reply-To: <1393441166-32692-9-git-send-email-sboyd@codeaurora.org>
References: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
 <1393441166-32692-9-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140227083856.GB9195@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> PM8921 and PM8058 are PMICs found paired with MSM8960 and MSM8660
> devices respectively. They contain subdevices such as keypads,
> RTC, regulators, clocks, etc.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../devicetree/bindings/mfd/qcom,pm8xxx.txt        | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8xxx.txt

This patch has been on the MLs for some time now and hasn't received
any feedback from the DT guys.

Patch looks good (despite the lack IRQ defines), applied.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
