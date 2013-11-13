From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 13 Nov 2013 10:04:39 +0100
Subject: [PATCH 1/3] can: mcp251x: Convert driver to use common clk
 framework
In-Reply-To: <1384332144-15211-1-git-send-email-shc_work@mail.ru>
References: <1384332144-15211-1-git-send-email-shc_work@mail.ru>
Message-ID: <528340A7.9080708@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

as this series adds device tree bindings, please add
devicetree at vger.kernel.org on Cc for the whole series.

On 11/13/2013 09:42 AM, Alexander Shiyan wrote:
> This patch converts mcp251x driver to using common clk framework
> for getting input frequency. The change was made for the preparation
> of the driver work with the devicetree. As a result private header
> for the driver is eliminated.
> Additionally, all existing users of the driver was converted to use
> this feature.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Looks good from my point of view. I'll take the whole series via the
linux-can tree, if there are no objections. I'd like to have the pxa and
imx maintainer's Ack and an Ack from the DT list.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/529c9290/attachment-0001.sig>
