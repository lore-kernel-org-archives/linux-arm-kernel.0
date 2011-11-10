From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Nov 2011 12:09:14 +0100
Subject: [PATCH v4] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <3D55990BDF4852409EA769663F22E54AC182CF@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1320891899-16135-1-git-send-email-b39297@freescale.com>
 <4EBBA3D6.9000300@pengutronix.de>
 <20111110102037.GC2503@pengutronix.de>
 <3D55990BDF4852409EA769663F22E54AC182CF@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <20111110110914.GD2503@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>   I changed the code to unset i2c client data just when gipochip_remove successes,
> Otherwise, there will be problems next time the remove function is called.

The i2c-core will do it on probe-failure and on remove. Check e4a7b9b0.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111110/615d0fc8/attachment.sig>
