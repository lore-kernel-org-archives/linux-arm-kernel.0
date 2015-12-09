From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Dec 2015 10:17:44 +0100
Subject: [PATCH v5] clk: sunxi: Add CLK_OF_DECLARE support for
 sun8i-a23-apb0-clk driver
In-Reply-To: <1449126330-21595-1-git-send-email-wens@csie.org>
References: <1449126330-21595-1-git-send-email-wens@csie.org>
Message-ID: <20151209091744.GW27957@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 03:05:30PM +0800, Chen-Yu Tsai wrote:
> The APBS clock on sun9i is the same as the APB0 clock on sun8i. With
> sun9i we are supporting the PRCM clocks by using CLK_OF_DECLARE,
> instead of through a PRCM mfd device and subdevices for each clock
> and reset control. As such we need a CLK_OF_DECLARE version of
> the sun8i-a23-apb0-clk driver.
> 
> Also, build it for sun9i/A80, and not just for configurations with
> MFD_SUN6I_PRCM enabled.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151209/dca9d3d5/attachment.sig>
