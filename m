From: brendanhiggins@google.com (Brendan Higgins)
Date: Thu, 15 Feb 2018 18:40:08 -0800
Subject: [PATCH v11 0/3] arm: npcm: add basic support for Nuvoton BMCs
Message-ID: <20180216024011.189157-1-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Addressed comments from:
 - Arnd: https://www.spinics.net/lists/arm-kernel/msg634442.html
 - Joel: https://www.spinics.net/lists/arm-kernel/msg634554.html


Summary of changes since previous update:
 - More device tree and binding doc clean up.

All changes tested on Nuvoton NPCM750 EVB.

I went ahead and decided to submit a pull request to Arnd, Olof, and
Kevin, as requested since I figured that we were about at the end of
feedback and we want to get this in.
