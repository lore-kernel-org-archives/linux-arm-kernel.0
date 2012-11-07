From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 07 Nov 2012 13:20:41 +0100
Subject: [PATCH 02/10] arm: at91: move platfarm_data to
 include/linux/platform_data/atmel.h
In-Reply-To: <1352287374-25176-2-git-send-email-plagnioj@jcrosoft.com>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
 <1352287374-25176-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <509A5219.2080408@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2012 12:22 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: linux-ide at vger.kernel.org
> Cc: linux-input at vger.kernel.org
> Cc: linux-mmc at vger.kernel.org
> Cc: linux-can at vger.kernel.org
> Cc: netdev at vger.kernel.org
> Cc: linux-pcmcia at lists.infradead.org
> Cc: rtc-linux at googlegroups.com
> Cc: spi-devel-general at lists.sourceforge.net
> Cc: linux-serial at vger.kernel.org
> Cc: linux-usb at vger.kernel.org
> Cc: linux-fbdev at vger.kernel.org
> ---
> HI all,
> 
> 	If it's ok with everyone this will go via at91
> 	with the patch serie than clean up the include/mach

Fine with me.

> 	For preparation to switch to arm multiarch kernel

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> (for the CAN related changes)

Marc


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/46c5f879/attachment.sig>
