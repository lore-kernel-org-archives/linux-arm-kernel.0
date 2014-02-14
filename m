From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 14 Feb 2014 10:43:21 +0200
Subject: [PATCHv14][ 3/4] video: Kconfig: Allow more broad selection of
 the imxfb framebuffer driver.
In-Reply-To: <1390410577-22073-3-git-send-email-denis@eukrea.com>
References: <1390410577-22073-1-git-send-email-denis@eukrea.com>
 <1390410577-22073-3-git-send-email-denis@eukrea.com>
Message-ID: <52FDD729.60405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22/01/14 19:09, Denis Carikli wrote:
> Without that patch, a user can't select the imxfb driver when the i.MX25 and/or
>   the i.MX27 device tree board are selected and that no boards that selects
>   IMX_HAVE_PLATFORM_IMX_FB are compiled in.
> 
> Cc: Eric B?nard <eric@eukrea.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-fbdev at vger.kernel.org
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied for 3.14 fbdev fixes.

As a generic comment, I'd appreciate if you'd use normal formatting in
the patch descriptions (no double spaces in the beginning of the lines).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140214/b4a85b49/attachment.sig>
