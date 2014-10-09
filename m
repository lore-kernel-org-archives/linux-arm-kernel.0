From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 9 Oct 2014 09:57:04 -0600
Subject: [PATCH v8 2/7] arm: dts: qcom: Add power-controller device node
 for 8974 Krait CPUs
In-Reply-To: <54347473.5010605@codeaurora.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-3-git-send-email-lina.iyer@linaro.org>
 <54347473.5010605@codeaurora.org>
Message-ID: <20141009155704.GC1277@ilina-mac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07 2014 at 17:17 -0600, Stephen Boyd wrote:
>On 10/07/2014 02:41 PM, Lina Iyer wrote:
>>@@ -144,7 +148,27 @@
>>  			};
>>  		};
>>-		saw_l2: regulator at f9012000 {
>>+		saw0: power-controller at f9089000 {
>>+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
>>+			reg = <0xf9089000 0x1000>;
>
>Please add the aliases.
Will do.
>
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>hosted by The Linux Foundation
>
