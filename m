From: jason77.wang@gmail.com (Jason Wang)
Date: Thu, 24 Jun 2010 21:11:27 +0800
Subject: [PATCH V3 0/2]Add mxc common 3ds debugboard support
Message-ID: <1277385089-7399-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

part2(v3):

Diff VS v1:
1) change file name from cpld_debugboard to 3ds_debugboard.
2) move all macro definitions from 3ds_debugboard.h to 3ds_debugboard.c
3) add a wrapper function in the 3ds_debugboard.c for lan9127 init.

Diff VS v2:
1) remove wrapper function for lan in 3ds_debugboard.c and 3ds_debugboard.h,
   move registration of lan device to mxc_expio_init().
2) modify calling 3ds debugboard related init function in mach-mx31_3ds.c

 [PATCH 1/2] mxc: add common debug board for 3-stack platforms
 [PATCH 2/2] mx31_3ds: revert 3ds debug board relate code
