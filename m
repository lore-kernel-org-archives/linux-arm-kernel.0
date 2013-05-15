From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 16 May 2013 01:53:29 +0400
Subject: [PATCH v4 0/3] R8A7779/Marzen R-Car VIN driver support
Message-ID: <201305160153.29827.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130515v2' tag and my recent yet unapplied USB/I2C patches.
Here we add the VIN driver platform code for the R8A7779/Marzen with ADV7180
I2C video decoder.

[1/3] ARM: shmobile: r8a7779: add VIN support
[2/3] ARM: shmobile: Marzen: add VIN and ADV7180 support
[3/3] ARM: shmobile: Marzen: enable VIN and ADV7180 in defconfig

   The VIN driver itself has been excluded from the series as it will be developed
against Mauro's 'media_tree.git' plus some yet unapplied patches in the future...

WBR, Sergei
