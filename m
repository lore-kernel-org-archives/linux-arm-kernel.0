From: skrishnakar@gmail.com (srikanth krishnakar)
Date: Mon, 30 Dec 2013 15:10:46 +0530
Subject: U-boot [with DT] for R-Car H1 (R8A7779) Linux-3.10 backport from
 renesas-backport.git
Message-ID: <CALDxG5g7mXPYLg7upNds1+UzFw3Z3W--xZ-qK6f_wtbqB9qB4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello All,

I am trying to boot the renesas-backport
https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-backport.git/
 kernel from branch backport/3.10.18/for-ltsi. Here the machine
supports DT boot method, where as I am unable to find corresponding
u-boot for R-Car H1 (Mazen) board, to boot with DTB (LIBFDT) support.

Board file: https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-backport.git/tree/arch/arm/mach-shmobile/board-marzen.c?h=backport/3.10.18/for-ltsi

However I found u-boot-sh :
http://git.denx.de/?p=u-boot/u-boot-sh.git;a=summary, here I don't
find any marzen specific config file or related files for RA87779
machine. All I found is from machine R8A7790. They both have two
different machine files in backported kernel.

Can anyone please let me know the actual u-boot and machine name which
supports DT enabled boot method for R-Car H1 or R8A7779 machine ?

Appreciate your replies.


Regards
Srikanth
