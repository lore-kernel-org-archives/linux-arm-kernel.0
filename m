From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 17 Jun 2016 11:04:03 +0200
Subject: [RFC] can: c_can: Update D_CAN TX and RX functions to 32 bit.
In-Reply-To: <1466093419-27575-2-git-send-email-tthayer@opensource.altera.com>
References: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
 <1466093419-27575-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <612130a4-30ea-ed73-ac8e-dabe7919ec35@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2016 06:10 PM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> When testing CAN write floods on Altera's CycloneV, the
> first 2 bytes are sometimes 0x00, 0x00 or corrupted
> instead of the values sent. Also observed bytes 4 & 5
> were corrupted in some cases.
> 
> The D_CAN Data registers are 32 bits and changing from
> 16 bit writes to 32 bit writes fixes the problem.
> 
> Testing performed on Altera CycloneV (D_CAN).
> Requesting tests on other C_CAN & D_CAN platforms.
> 
> Reported-by: Richard Andrysek <richard.andrysek@gomtec.de>
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>

Applied to can with stable on Cc.

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
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160617/fcc0cd34/attachment.sig>
