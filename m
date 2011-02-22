From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 22 Feb 2011 17:36:06 +0100
Subject: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <201102221715.07480.arnd@arndb.de>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
	<20110222085256.GA19871@S2100-06.ap.freescale.net>
	<20110222103349.GA2755@pengutronix.de>
	<201102221715.07480.arnd@arndb.de>
Message-ID: <20110222163606.GK2755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 05:15:07PM +0100, Arnd Bergmann wrote:
> On Tuesday 22 February 2011, Wolfram Sang wrote:
> > # mount -t vfat /dev/mmcblk0p1 /mnt
> > # dd if=/mnt/test.dat of=/tmp/a bs=1024
> > # umount /mnt
> > # ./dd --version
> > dd (coreutils) 8.5
> 
> In general, you should try to rule out file system, garbage collection,
> partitioning and cache effects.

Yes, right, I am aware of that (well, most of it ;)). I simplified my
testcase here, because I was sure by previous tests it was only
dependent on the frequency requested by the card. Remember, I wasn't
after maximum values but chasing a difference in read performance of two
magnitudes.


Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/e97edfa7/attachment.sig>
