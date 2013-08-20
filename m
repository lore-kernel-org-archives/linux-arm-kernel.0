From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 20 Aug 2013 10:59:01 +0200
Subject: [PATCH v2 3/3] can: mcp251x: Allow tuning SPI mode and limit
 maximal SPI speed
In-Reply-To: <1376912361-22133-3-git-send-email-shc_work@mail.ru>
References: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
 <1376912361-22133-3-git-send-email-shc_work@mail.ru>
Message-ID: <52132FD5.7070807@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 01:39 PM, Alexander Shiyan wrote:
> Patch allow to use different mode settings for SPI (MODE3 for example)
> and limit maximal speed according to IC datasheet.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied to linux-can-next/testing

tnx,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130820/d36f3cd3/attachment.sig>
