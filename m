From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 17 May 2013 01:22:33 +0400
Subject: [PATCH v4 0/3] R8A7778/BOCK-W R-Car VIN driver support
Message-ID: <201305170122.33996.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130515v2' tag and my recent yet unapplied patches. Here we
add the VIN platform code working on
the R8A7778/BOCK-W with ML86V7667. The driver patch also applies (with offsets)
to Mauro's 'media_tree.git'...

[1/3] ARM: shmobile: r8a7778: add VIN support
[2/3] ARM: shmobile: BOCK-W: add VIN and ML86V7667 support
[3/3] ARM: shmobile: BOCK-W: enable VIN and ML86V7667 in defconfig

   The patch containing OKI ML86V7667 video decoder driver has been removed
from the series as it should be applied to the 'media_tree.git' repo. The patch
containing the VIN PFC support has been also removed from the series and has
now been merged.

WBR, Sergei
