From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 23:45:32 +0100
Subject: [GIT PULL v2] Qualcomm SoC Updates for 4.6
In-Reply-To: <1456800223-29655-1-git-send-email-andy.gross@linaro.org>
References: <1456800223-29655-1-git-send-email-andy.gross@linaro.org>
Message-ID: <5104383.iHbTzhTmfy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 20:43:43 Andy Gross wrote:
> Qualcomm ARM Based SoC Updates for v4.6
> 
> * Add stubs for smem_state to fix build issues
> * Fix module usage in SPM driver
> * Add i2c and spi entries into QCOM MAINTAINERS entry
> * Add SMD multi channel support
> * Drop ARCH_MSM* configs and fixup clocksource support
> * Add clks to QCOM MAINTAINERS
> * Fix smp2p memset issue

I never really know how to categorize drivers/soc here. I was
about to put it all into next/drivers, but you also have
a few changes that normally go into next/soc.

If it's ok for you, could you respin this once more into
two separate series to split out drivers/soc/*

	Arnd
