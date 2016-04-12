From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Tue, 12 Apr 2016 13:57:48 +0200
Subject: [PATCH 2/2] ARM: multi_v5_defconfig: Enable recommended options
 for systemd
In-Reply-To: <1458991706-30109-2-git-send-email-jlu@pengutronix.de>
References: <1458991706-30109-1-git-send-email-jlu@pengutronix.de>
 <1458991706-30109-2-git-send-email-jlu@pengutronix.de>
Message-ID: <1460462268.2629.27.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sa, 2016-03-26 at 12:28 +0100, Jan Luebbe wrote:
> Enable FHANDLE, CGROUPS, BLK_DEV_BSG and DEVTMPFS as recommended by
> systemd (which also matches the multi_v7 defconfig). Also enable IPV6,
> which defaults to 'y' by now.
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>

Shawn, you've already applied 1/2. Do you have any concerns or comments
regarding this one?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
