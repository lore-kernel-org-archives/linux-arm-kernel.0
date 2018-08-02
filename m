From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 2 Aug 2018 12:47:27 +0200
Subject: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180802104443.GH9117@sirena.org.uk>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
Message-ID: <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.08.2018 12:44, Mark Brown wrote:
> On Thu, Aug 02, 2018 at 12:34:22PM +0200, Oleksij Rempel wrote:
>> Export pm_power_off_prepare. It is needed to implement power off on
>> Freescale/NXP iMX6 based boards with external power management
>> integrated circuit (PMIC).
> 
> I thought we'd got an ack for this from Raphael on a previous version or
> am I mistaken?
> 

No, we got an:
"Anyway, I have no particular problems with exporting
pm_power_off_prepare via EXPORT_SYMBOL_GPL()."

Should i see it as ACK?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180802/3f8ff04c/attachment.sig>
