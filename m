From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Apr 2012 12:48:50 -0600
Subject: [PATCH v2 1/6] ARM: tegra: do not hide dma declarations
In-Reply-To: <1330721903-8571-1-git-send-email-alan@signal11.us>
References: <1330721903-8571-1-git-send-email-alan@signal11.us>
Message-ID: <4F8C6992.7010508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2012 01:58 PM, Alan Ott wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The declarations are actually required for the device
> definitions, and are still valid even if the dma controller
> is disabled:
> 
> arch/arm/mach-tegra/devices.c:559:12: error: 'TEGRA_DMA_REQ_SEL_I2S_1' undeclared here (not in a function)
> arch/arm/mach-tegra/devices.c:577:12: error: 'TEGRA_DMA_REQ_SEL_I2S2_1' undeclared here (not in a function)
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alan Ott <alan@signal11.us>

Applied, thanks.
