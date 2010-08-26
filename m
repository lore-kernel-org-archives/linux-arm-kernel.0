From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 26 Aug 2010 15:28:35 +0900
Subject: [PATCH V2] ARM: S5PV310: Update clocks
Message-ID: <1282804120-17241-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is second version for updating clocks for S5PV310/S5PC210.
Thanks for MyungJoo Ham's pointing out.

Following is changes since v1:
- Restored some clocks which can be used for CPU_FREQ 
- Added 'uart0'
- Fix on Watchdog timer clock
- Restored(removed) regarding MIPI clocks

[PATCH V2 02/14] ARM: S5PV310: Removed unused clock
[PATCH V2 10/14] ARM: S5PV310: Adds uart clocks
[PATCH V2 12/14] ARM: S5PV310: Add various clocks
[PATCH V2 13/14] ARM: S5PV310: Add video clocks
[PATCH V2 14/14] ARM: S5PV310: Adds various special clocks
