From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sun, 20 Apr 2014 20:52:11 +0200
Subject: [RFC PATCH 0/2] usb: Reuse fsl driver code for synopsys usb
 controller
In-Reply-To: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
References: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
Message-ID: <5354175B.3070109@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2014 06:27 PM, Punnaiah Choudary Kalluri wrote:
> Zynq soc contains a dual role usb controller and this IP is from synopsys. We
> observed that there is driver available for this controller from freescale and
> decided to reuse this driver for zynq use.

Have a look drivers/usb/chipidea. It's maintained by Peter Chen (Cc'ed)
and is in better shape than the freescale driver.

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
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140420/d9c20ad5/attachment.sig>
