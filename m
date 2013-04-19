From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 20 Apr 2013 02:17:32 +0400
Subject: [PATCH v2 0/1] Add I2C support to R8A7778/BOCK-W
Message-ID: <201304200217.32844.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the patch against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130417' tag and my recent yet unapplied USB patches.
Here we add I2C support to the R8A7778 platform code. This will be
important in the future for the VIN driver since the video sensor chip
is controller via I2C bus #0 on BOCK-W. 

[1/1] ARM: shmobile: r8a7778: add I2C support

The patch #2 (ARM: shmobile: BOCK-W: enable I2C in defconfig) has been
already merged, and so not reposted.

WBR, Sergei
