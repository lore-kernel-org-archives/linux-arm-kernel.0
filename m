From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 10:35:13 -0800
Subject: [PATCH v2 1/6] ARM: tegra: do not hide dma declarations
In-Reply-To: <1330721903-8571-1-git-send-email-alan@signal11.us>
References: <1330721903-8571-1-git-send-email-alan@signal11.us>
Message-ID: <20120304183513.GA31064@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 03:58:23PM -0500, Alan Ott wrote:
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

Thanks, applied to cleanups-and-fixes for 3.4.


-Olof
