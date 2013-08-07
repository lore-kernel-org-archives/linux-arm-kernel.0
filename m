From: davidb@codeaurora.org (David Brown)
Date: Wed, 7 Aug 2013 10:40:53 -0700
Subject: [PATCH] [TRIVIAL] ARM: msm: fix compilation error in gpiomux
In-Reply-To: <1375857279-18082-1-git-send-email-k.kozlowski@samsung.com>
References: <1375857279-18082-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20130807174053.GA17551@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 08:34:39AM +0200, Krzysztof Kozlowski wrote:
>Fix compilation error in gpiomux (CONFIG_MSM_GPIOMUX=y):
>arch/arm/mach-msm/gpiomux.c:24:13: error: static declaration of
>	?__msm_gpiomux_write? follows non-static declaration
>arch/arm/mach-msm/gpiomux.h:85:6: note: previous declaration of
>	?__msm_gpiomux_write? was here
>
>Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks, I'll pull this in.

  <https://patchwork.kernel.org/patch/2839921/>

Daivd

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
