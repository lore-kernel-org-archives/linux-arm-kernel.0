From: jason77.wang@gmail.com (Jason Wang)
Date: Tue, 22 Jun 2010 22:27:29 +0800
Subject: [PATCH V2 0/2]Add mxc 3ds CPLD debugboard support
Message-ID: <1277216851-15782-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

part2(v2):

Diff VS v1:
1) change file name from cpld_debugboard to 3ds_debugboard.
2) move all macro definitions from 3ds_debugboard.h to 3ds_debugboard.c
3) add a wrapper function in the 3ds_debugboard.c for lan9127 init.

I have validated build test for mx31_3ds for v2, and performed boot test
for V1 on mx31_3ds(NFS worked fine).

 [PATCH 1/2] mxc: add common debug board for 3-stack platforms
 [PATCH 2/2] mx31_3ds: revert 3ds debug board relate code
