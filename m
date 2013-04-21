From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 21 Apr 2013 22:37:22 +0400
Subject: [PATCH v2 0/5] OKI ML86V7667 driver and R8A7778/BOCK-W VIN support
Message-ID: <201304212237.23500.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 5 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130419' tag and my recent yet unapplied patches. Here we
add the OKI ML86V7667 video decoder driver and the VIN platform code working on
the R8A7778/BOCK-W with ML86V7667. The driver patch also applies (with offsets)
to Mauro's 'media_tree.git'...

[1/5] V4L2: I2C: ML86V7667 video decoder driver
[2/5] sh-pfc: r8a7778: add VIN pin groups
[3/5] ARM: shmobile: r8a7778: add VIN support
[4/5] ARM: shmobile: BOCK-W: add VIN and ML86V7667 support
[5/5] ARM: shmobile: BOCK-W: enable VIN and ML86V7667 in defconfig

WBR, Sergei
