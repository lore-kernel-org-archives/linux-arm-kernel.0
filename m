From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 14 Jun 2012 19:59:50 +0200
Subject: [PATCH v2 00/17] Big OMAP I2C Cleanup
In-Reply-To: <1339691067-919-1-git-send-email-balbi@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
Message-ID: <20120614175950.GE14419@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 07:24:10PM +0300, Felipe Balbi wrote:
> Hi guys,
> 
> I have dropped a few patches from the series and also
> tested every single patch on my pandaboard. I2C messages
> are still working fine with panda after each patch.
> 
> There's still lots of work to be done on the i2c-omap.c
> driver but it's now easier to read, IMO.
> 
> Changes since v1:
> 	- removed tabification on patch 6/17
> 	- removed dev_err() which was introduced on patch 09/17

To prevent the list being flooded, I would appreciate if you could wait
a few days to collect reviews before resending. It will take some time
until I pick this series anyhow, because I want people to have time to
donate Tested-by tags.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/1815f03f/attachment.sig>
