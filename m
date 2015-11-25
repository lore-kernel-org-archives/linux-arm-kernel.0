From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 13:51:50 +0100
Subject: [PATCH 3/3] ARM: qcom: Drop ARCH_MSM* configs
In-Reply-To: <5655A94B.3030304@linaro.org>
References: <1448413710-8101-1-git-send-email-sboyd@codeaurora.org>
 <1448413710-8101-4-git-send-email-sboyd@codeaurora.org>
 <5655A94B.3030304@linaro.org>
Message-ID: <3990433.OKhWpPeunI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 13:27:55 Daniel Lezcano wrote:
> 
> What about:
> 
> textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
> textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> 
> in arch/arm/Makefile

Good point, we need to do something about these still.

> and
> 
> CONFIG_ARCH_MSM8X60=y
> CONFIG_ARCH_MSM8960=y
> CONFIG_ARCH_MSM8974=y
> 
> in arch/arm/configs/qcom_defconfig and multi_v7_defconfig
> 
> ?

These should be removed, but they are harmless.

	Arnd
