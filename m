From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 20 Mar 2015 10:06:58 +0100
Subject: [PATCH 11/13] can: at91_can: use endian agnostic IO accessors
In-Reply-To: <1426693992-31163-12-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-12-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <550BE332.1030901@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2015 04:53 PM, Ben Dooks wrote:
> Change __raw accesors to  endian agnostic versions to allow the driver
> to work properly on big endian systems.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

applied to can-next.

Thanks,
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
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150320/24c639df/attachment.sig>
