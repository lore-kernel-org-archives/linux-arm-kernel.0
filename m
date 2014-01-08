From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Jan 2014 21:38:13 +0000
Subject: [PATCH v3 7/7] devicetree: bindings: Document PM8921/8058 PMICs
In-Reply-To: <1389206270-3728-8-git-send-email-sboyd@codeaurora.org>
References: <1389206270-3728-1-git-send-email-sboyd@codeaurora.org>
 <1389206270-3728-8-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140108213813.GC18611@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> PM8921 and PM8058 are PMICs found paired with MSM8960 and MSM8660
> devices respectively. They contain subdevices such as keypads,
> RTCs, regulators, clocks, etc.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../devicetree/bindings/mfd/qcom,pm8xxx.txt        | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8xxx.txt

Just waiting on the Ack for this one now.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
