From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 21 Sep 2014 18:46:29 +0200
Subject: [PATCH v2 0/2] watchdog: sunxi: Add A31 watchdog support
In-Reply-To: <1411315519-26257-1-git-send-email-wens@csie.org>
References: <1411315519-26257-1-git-send-email-wens@csie.org>
Message-ID: <20140921164629.GB15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 22, 2014 at 12:05:17AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> This is v2 of the Allwinner A31 watchdog support series. This series adds
> support for the watchdog hardware found in Allwinner A31 and later SoCs.
> These new chips have multiple watchdogs, with separate interrupt lines
> and registers, but the basic layout and operation is the same. This series
> is based on Guenter's restart handler series.
> 
> Patch 1 prepares the sunxi-wdt driver for varying register offsets tied to
> compatible strings. Various ioread32/iowrite32 calls have been replaced with
> readl/writel as well.
> 
> Patch 2 adds the sun6i compatible string with accompanying register offset
> data.
> 
> I tested this series on my Cubieboard (sun4i) and A23 tablet (sun8i), which
> has the same watchdog hardware as the A31 (sun6i). This covers the 2 classes
> of hardware supported.
> 
> After this series is merged, we can remove the power/reset driver for sun6i.
> 
> 
> Changes since v1:
>   - Mention replacing ioread32/iowrite32 calls in patch 1 commit message.

On the whole series,

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140921/5f1178ab/attachment.sig>
