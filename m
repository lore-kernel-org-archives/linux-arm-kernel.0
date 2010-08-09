From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 15:20:44 +0200
Subject: [v2] Add i.MX51 support to mxc_nand
Message-ID: <1281360053-8386-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In this series I swapped the "fix correct_data function" with the
"support 8bit ecc" patch as suggested by Baruch. Also, I integrated
the patches sent by John Ogness. John, I hope I addressed all your
patches, it would be good if you could test them on 16bit flash as
you seem to be the only one having a board with such a flash.

Sascha
