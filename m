From: jason77.wang@gmail.com (Jason Wang)
Date: Thu,  3 Jun 2010 20:05:43 +0800
Subject: [V2 0/3]Add i.MX51 3-stack board support
Message-ID: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Comparing with V1, several changes are made in V2:

1) drop iomux-mx51-3ds.h and move its contents to iomux-mx51.h
2) move keypad device definition to devices.c
3) fix all remaining comments from Sascha, Amit and Fabio.


[V2 1/3] mxc: Add support for the imx51 3-stack board
[V2 2/3] mxc/iomux: add GPIO bank offset for iomux v3 platforms
[V2 3/3] mx51/keypad: add keypad support for i.MX51 platforms
