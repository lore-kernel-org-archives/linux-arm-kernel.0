From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 2 May 2018 15:18:06 +0200
Subject: [PATCH v8 12/12] ARM: shmobile: Convert file to use cntvoff
In-Reply-To: <20180502063639.qa7bzqxzrejd4kh2@verge.net.au>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
 <20180501123131.7738-13-mylene.josserand@bootlin.com>
 <20180502063639.qa7bzqxzrejd4kh2@verge.net.au>
Message-ID: <20180502131806.5aybrfzll7wdoybv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, May 02, 2018 at 08:36:39AM +0200, Simon Horman wrote:
> On Tue, May 01, 2018 at 02:31:31PM +0200, Myl?ne Josserand wrote:
> > Now that a common function is available for CNTVOFF's
> > initialization, let's convert shmobile-apmu code to use
> > this function.
> > 
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

For the sake of bisectability (and to ease the merge), is it ok if we
take it through the sunxi (and then arm-soc) tree?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/767edd70/attachment.sig>
