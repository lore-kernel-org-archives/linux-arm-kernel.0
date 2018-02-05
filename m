From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Feb 2018 14:46:38 +0100
Subject: [PATCH 09/20] clk: sunxi-ng: Remove SUNXI_CCU_* selects
In-Reply-To: <20180205012146.23981-10-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-10-ulfalizer@gmail.com>
Message-ID: <20180205134638.ugngvfmdixnpxihk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Mon, Feb 05, 2018 at 02:21:21AM +0100, Ulf Magnusson wrote:
> The selected symbols were removed in commit 06e226c7fb23 ("clk:
> sunxi-ng: Move all clock types to a library").
> 
> Remove the selects from SUN4I_A10_CCU.
> 
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>

This has already been submitted by Corentin:
https://patchwork.kernel.org/patch/10175435/

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180205/5dadb51f/attachment.sig>
