From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Aug 2012 23:31:24 +0100
Subject: [PATCH 3/5] ASoC: Davinci: pcm: Add device tree bindings
In-Reply-To: <1344948125-5649-4-git-send-email-gururaja.hebbar@ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-4-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120817223122.GA21445@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 06:12:03PM +0530, Hebbar, Gururaja wrote:
> Device tree support for Davinci/OMAP2+ pcm driver.

This looks like it's a device which maps a shared DMA controller in the
SoC core into ASoC rather than actual hardware.  Such devices are
usually instantiated automatically from the DAI rather than being
represented in the device tree since they are a Linux internal thing
really - the Tegra and Freescale drivers provide examples of how this
sort of thing can be done.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/a4832abd/attachment.sig>
