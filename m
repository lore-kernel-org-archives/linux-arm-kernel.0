From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 17:55:04 +0200
Subject: [GIT PULL 6/8] ARM: tegra: device tree changes
In-Reply-To: <1365181426-11547-6-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-6-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201304091755.04661.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Stephen Warren wrote:
> This branch contains the majority of the device tree changes for Tegra.
> Highlights include:
> 
> * Many changes for Tegra114, and the Dalmore board, to enable pinctrl,
>   SDHCI/MMC, PWM, DMA, I2C, KBC, SPI, battery, regulators.
> * Adding or enabling suspend wakeup sources on many boards, and adding
>   suspend timing parameters, to support the system suspend patches.
> * Adding clocks to the audio-related nodes, so that in 3.11, the audio
>   driver can pull these clocks from device tree rather than hard-coding
>   clock names.
> * Some small DT fixes/cleanup.
> 
> This branch is based on the previous clk pull request.

I ended up doing a next/dt2 branch for this, since the mxs tree has the
same kind of dependency.

	Arnd
