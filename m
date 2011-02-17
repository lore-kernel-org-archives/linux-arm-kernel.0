From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 17 Feb 2011 15:31:27 +0100
Subject: [patch v2 0/5] Genesi Efika MX/SB support improvements 
Message-ID: <20110217143127.307109680@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This patch series aims at improving current efika mx support and adds support
for efika smartbook. Given the similarities between the two systems, the first
patch moves mx some code into a new file which will contain code shared by both
systems and the last patch adds support for efika smartbook.

Change since v1:
- rebased on ehci cleanup patches (which seems to be now merged in
  Sascha's imx for-next tree)
- use machine_is_* in initcalls
- drop dead uart-related code

Arnaud
