From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Sep 2018 11:21:43 -0700
Subject: Regression in next with apps hanging with vm_fault_t
Message-ID: <20180910182143.GW5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm seeing a regression with Linux next with commit 7b6ec2ae877a
("fs: convert return type int to vm_fault_t") where apps can just
hang.

The reproducable test case I have is to remove a distro package
and then add it back where adding the package back just hangs and
the package file seems corrupted.

This is with ext4 rootfs on MMC, NFSroot does not have this
issue. Any ideas?

Regards,

Tony
