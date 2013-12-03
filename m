From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 03 Dec 2013 09:34:09 +0100
Subject: [PATCH v4 16/17] usb: phy-mxs: fix the problem by only using
 1st controller's register
In-Reply-To: <1386056231-17258-17-git-send-email-peter.chen@freescale.com>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
 <1386056231-17258-17-git-send-email-peter.chen@freescale.com>
Message-ID: <529D9781.1080209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 08:37 AM, Peter Chen wrote:
> We fix the problem that we only use the 1st controller's related
> registers at mxs_phy_disconnect_line, but in fact, it needs to
> access registers according to different PHYs.

Are you fixing the code that has been added in this series before? If
so, please squash into the patch. Don't add the broken code in the first
place.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/bfee54e4/attachment-0001.sig>
