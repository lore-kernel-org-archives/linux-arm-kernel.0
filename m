From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:16:45 +0200
Subject: [PATCH v4 02/11] clk: sunxi-ng: a64: Add max. rate constraint to
 video PLLs
In-Reply-To: <20180904044053.15425-3-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-3-icenowy@aosc.io>
Message-ID: <20180905071645.ibhcuq5coc6gl6k3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 12:40:44PM +0800, Icenowy Zheng wrote:
> Video PLLs on A64 can be set to higher rate that it is actually
> supported by HW.
> 
> Limit maximum rate to 1008 MHz. This is the maximum allowed rate by BSP
> clock driver. Interestengly, user manual specifies maximum frequency to
> be 600 MHz. Historically, this data was wrong in some user manuals for
> other SoCs, so more faith is put in BSP clock driver.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/a1c77e8b/attachment-0001.sig>
