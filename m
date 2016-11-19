From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 16:52:01 -0800
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.10
In-Reply-To: <7hpolw2uih.fsf@baylibre.com>
References: <7hpolw2uih.fsf@baylibre.com>
Message-ID: <20161119005201.GI15902@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 03:28:06PM -0800, Kevin Hilman wrote:
> Arnd, Olof,
> 
> Here are the arm64 DT changes for Amlogic family SoCs.
> 
> Please pull,
> 
> Thanks,
> 
> Kevin
> 
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64
> 
> for you to fetch changes up to ab5b24fdd2d551ea729e8e19e47811a646260331:
> 
>   ARM64: dts: meson-gxbb-vega-s95: Add SD/SDIO/MMC and PWM nodes (2016-11-15 12:05:54 -0800)
> 
> ----------------------------------------------------------------
> Amlogic DT changes for 64-bit platforms for v4.10
> 
> Support for new drivers:
> - USB
> - i2c
> - SPI
> - mailbox/MHU
> - PWM
> - ethernet MAC, PHY
> - secure monitor
> - IR
> - watchdog

Merged, thanks. This platform is coming along nicely.


-Olof
