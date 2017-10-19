From: brendanhiggins@google.com (Brendan Higgins)
Date: Thu, 19 Oct 2017 15:50:47 -0700
Subject: [PATCH v7 0/3] arm: npcm: add basic support for Nuvoton BMCs
Message-ID: <20171019225050.25410-1-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addressed comments from:
  - Rob: http://www.spinics.net/lists/devicetree/msg196376.html

Changes since previous update:
  - Moved all memory mapped nodes to busses.
  - Map ranges starting at 0
  - Moved external clocks to root
  - No changes to mach-npcm since v5
  - No changes to MAINTAINERS since v5

Changes have been tested on the NPCM750 evaluation board.
