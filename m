From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 23 Apr 2013 20:12:57 +0400
Subject: [PATCH v3 0/1] Add I2C support to R8A7778/BOCK-W
Message-ID: <201304232012.57619.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the patch against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130422' tag and my recent yet unapplied USB patches.
Here we add I2C support to the R8A7778 platform code. This will be
important in the future for the VIN driver since the video decoder chip is
controlled via I2C bus #0 on BOCK-W. 

[1/1] ARM: shmobile: r8a7778: add I2C support

The patch #2 (ARM: shmobile: BOCK-W: enable I2C in defconfig) has been
already merged, and so not reposted.

WBR, Sergei
