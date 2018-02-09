From: dcb314@hotmail.com (David Binderman)
Date: Fri, 9 Feb 2018 15:39:27 +0000
Subject: linux-4.15 bug report
Message-ID: <HE1PR0802MB23315167D23949B9FA74C1409CF20@HE1PR0802MB2331.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

linux-4.15/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c:2083]: (warning) Redundant assignment of 'cfg.menu_skip_mask' to itself.

Source code is

      cfg.menu_skip_mask = cfg.menu_skip_mask;

Suggest either delete the code or do something useful.

Regards

David Binderman
