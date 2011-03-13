From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 13 Mar 2011 17:19:16 +0200
Subject: [PATCH v2 0/6] ARM: PXA: Z2: Zipit Z2 improvements series
Message-ID: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series attempts to improve Zipit Z2 support.

Changes since v1:
 - Removed OHCI and poweroff patches
 - Removed commented out stuff from 1st patch
 - Added patch to handle lid switch gracefully (it's switch, not button!)
