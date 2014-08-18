From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 18 Aug 2014 14:39:10 +0800
Subject: [PATCH] ARM: dts: Only build dtb if associated Arch and/or SoC
 is enabled
In-Reply-To: <1407852078-31309-1-git-send-email-pbrobinson@gmail.com>
References: <1407852078-31309-1-git-send-email-pbrobinson@gmail.com>
Message-ID: <20140818063908.GE2114@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 03:01:18PM +0100, Peter Robinson wrote:
> A number of arches (EXYNOS/IMX/TEGRA) are separated out into finer
> grained definitions whether it be sub ARCH or SOC definitions. The
> device tree blobs should only be built if the specific option is
> enabled that supports that device or it might be that there's an
> expectation that the device is supported when in actual fact it's
> not. This ensures only the relevant bits are built.
> 
> This also helps to avoid trivial merge conflicts when adding support
> for new boards.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

For IMX part,

Acked-by: Shawn Guo <shawn.guo@freescale.com>
