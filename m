From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 04 Apr 2013 16:25:42 +0200
Subject: [PATCH 2/2] mmc: mxs-mmc: add non-removeable property
In-Reply-To: <87r4iqpey3.fsf@octavius.laptop.org>
References: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
 <1364223751-28253-3-git-send-email-mkl@pengutronix.de>
 <87r4iqpey3.fsf@octavius.laptop.org>
Message-ID: <515D8D66.2040402@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 04:07 PM, Chris Ball wrote:
> Hi,
> 
> On Mon, Mar 25 2013, Marc Kleine-Budde wrote:
>> +	host->non_removeable = of_property_read_bool(np, "non-removable");
>> +	if (host->non_removeable)
>> +		mmc->caps |= MMC_CAP_NONREMOVABLE;
> 
> The correct spelling is "non_removable", as used in the DT property.
> 
> Thanks,

Will fix.

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130404/0d412978/attachment.sig>
