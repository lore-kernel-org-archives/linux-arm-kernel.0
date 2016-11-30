From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 16:56:27 +0100
Subject: [PATCH] arm64: defconfig: Do not lower CONFIG_LOG_BUF_SHIFT
In-Reply-To: <20161123145508.GK28723@e104818-lin.cambridge.arm.com>
References: <1479908176-13625-1-git-send-email-geert+renesas@glider.be>
 <20161123145508.GK28723@e104818-lin.cambridge.arm.com>
Message-ID: <5130697.hXkMK8a5Xn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 23, 2016 2:55:09 PM CET Catalin Marinas wrote:
> On Wed, Nov 23, 2016 at 02:36:16PM +0100, Geert Uytterhoeven wrote:
> > The default value of 17 for CONFIG_LOG_BUF_SHIFT is much more suitable
> > than 14. The latter easily leads to lost kernel messages on systems with
> > only one CPU core.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Applied on next/arm64, thanks!

	Arnd
