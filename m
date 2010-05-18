From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 18 May 2010 16:02:08 +0900
Subject: [PATCHv2] SAMSUNG: Audio support
Message-ID: <1274166128-6429-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 Following are few patches to define and add audio devices' support
for latest Samsung SoCs, namely S5P6440, S5P6442, S5PC100, S5PC110
and S5PV210 on respective SMDK board.
 The device drivers will be enabled to run these via ASoC tree.

Changes since v1:
	o Drop EXPORT_SYMBOL for platform device definitions

Thanks.
