From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 13 Feb 2012 13:58:23 +0100
Subject: [PATCH] ARM: S3C24XX: Fix restart on S3C2442
In-Reply-To: <201202131329.37465.GNUtoo@no-log.org>
References: <1329051929-8303-1-git-send-email-GNUtoo@no-log.org>
 <201202121957.10472.GNUtoo@no-log.org> <201202131329.37465.GNUtoo@no-log.org>
Message-ID: <201202131358.23652.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

Am Montag, 13. Februar 2012, 13:29:37 schrieb Denis 'GNUtoo' Carikli:
> >Thanks a lot for the patch.
> >It compiles fine.
> >Now time for me to look at runtime boot issues for my gta02.
> 
> I've now tested at runtime, here's the boot log:

[snipped boot log]

> It is now waiting for the rootfs that isn't there(since /dev/mmcblk0p1
> depend on a driver that is not mainline and that I only applied the patch
> to test on top of the master branch of linux-next).
> 
> Tested-by: Denis 'GNUtoo' Carikli" <GNUtoo@no-log.org>

thanks for testing, and for still working on the Freerunner. At some point I'd 
probably like to revive mine :-)

Heiko
