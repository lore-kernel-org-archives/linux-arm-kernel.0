From: brendanhiggins@google.com (Brendan Higgins)
Date: Tue, 13 Feb 2018 12:09:56 -0800
Subject: [PATCH v10 0/3] arm: npcm: add basic support for Nuvoton BMCs
Message-ID: <20180213200959.160157-1-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addressed comments from:
 - Joel: https://www.spinics.net/lists/arm-kernel/msg634074.html
 - Arnd: https://www.spinics.net/lists/arm-kernel/msg634091.html

Summary of changes since previous update:
 - Replaced "nuvoton,npcm7xx-smp" compatibility string with
   "nuvoton,npcm750-smp".
 - Fixed some whitespace issues.
 - Added EVB DTS to Makefile.

All changes tested on Nuvoton NPCM750 EVB.
