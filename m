From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Jun 2014 10:31:33 -0700
Subject: [PATCH] ARM: qcom: select GSBI from mach kconfig
In-Reply-To: <1402398980-24664-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1402398980-24664-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <539740F5.9030204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/14 04:16, Srinivas Kandagatla wrote:
> This patch adds GSBI selection automatically from mach kconfig, As GSBI
> seems to be the very basic SOC specific driver and serial driver depends on it.
> I think this option should be selected via mach kconfig rather than adding
> it to any defconfig.
>
> Without this patch multi_v7_defconfig can not show up console on
> IFC6410.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>

No, we should be getting rid of selects, not adding more. Just put this
in the multi_v7_defconfig.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
