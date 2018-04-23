From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 23 Apr 2018 09:14:21 +0200
Subject: [PATCH] ARM: dts: sun4i: Fix incorrect clocks for displays
In-Reply-To: <20180420102112.2843-1-dev@pascalroeleven.nl>
References: <20180420102112.2843-1-dev@pascalroeleven.nl>
Message-ID: <20180423071421.byupsz4gxpmhfe44@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 12:21:12PM +0200, Pascal Roeleven wrote:
> Some displays on SUN4i devices wouldn't properly stay on unless
> 'clk_ignore_unused' is used.
> 
> Change the duplicate clocks to the probably intended ones.
> 
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>

What was the difference with the first patch you sent?

Anyway, I've applied it, thanks

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180423/10a8cb19/attachment.sig>
