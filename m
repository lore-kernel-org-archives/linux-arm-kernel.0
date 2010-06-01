From: jason77.wang@gmail.com (Jason Wang)
Date: Tue,  1 Jun 2010 23:10:40 +0800
Subject: [PATCH 0/3]Add i.MX51 3-stack board support
Message-ID: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These three patches will add a i.MX51 3-stack board support.
Currently, on this board, only 3 devices(serial, ethernet and
keypad) are registered and validated.

[PATCH 1/3] mxc: Add support for the imx51 3-stack board
[PATCH 2/3] mxc/iomux: add GPIO bank offset for iomux v3 platforms
[PATCH 3/3] mx51/clock: add keypad clock definition and registration
