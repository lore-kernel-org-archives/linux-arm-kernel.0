From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 21 Feb 2010 12:33:08 +0200
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <20100221102807.GE18298@core.coreip.homeip.net>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002211210.12306.anarsoul@gmail.com>
	<20100221102807.GE18298@core.coreip.homeip.net>
Message-ID: <201002211233.11842.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 21 ??????? 2010 12:28:07 ????? Dmitry Torokhov ???????:

> While flooding does it report BTN_TOUCH as up or down? I might have messed
> s3c24xx_ts_check_pen_down()...

Nope, it reports coordinates, here's part of evtest output.

Regards,
Vasily

Event: time 1254477272.320125, type 3 (Absolute), code 0 (X), value 515
Event: time 1254477272.320158, type 3 (Absolute), code 1 (Y), value 496
Event: time 1254477272.320179, -------------- Report Sync ------------ 
Event: time 1254477272.333973, type 3 (Absolute), code 1 (Y), value 497
Event: time 1254477272.334012, -------------- Report Sync ------------ 
Event: time 1254477272.374775, type 3 (Absolute), code 0 (X), value 516
Event: time 1254477272.374824, -------------- Report Sync ------------ 
Event: time 1254477272.388559, type 3 (Absolute), code 0 (X), value 515
Event: time 1254477272.388591, type 3 (Absolute), code 1 (Y), value 498
Event: time 1254477272.388612, -------------- Report Sync ------------ 
Event: time 1254477272.402415, type 3 (Absolute), code 1 (Y), value 497
Event: time 1254477272.402456, -------------- Report Sync ------------ 
Event: time 1254477272.456858, type 3 (Absolute), code 1 (Y), value 496
Event: time 1254477272.456901, -------------- Report Sync ------------ 
Event: time 1254477272.470573, type 3 (Absolute), code 1 (Y), value 497
Event: time 1254477272.470615, -------------- Report Sync ------------ 
Event: time 1254477272.484288, type 3 (Absolute), code 1 (Y), value 498
Event: time 1254477272.484330, -------------- Report Sync ------------
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100221/2eff27e2/attachment.sig>
