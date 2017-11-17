From: brendanhiggins@google.com (Brendan Higgins)
Date: Fri, 17 Nov 2017 11:07:44 -0800
Subject: [PATCH v8 0/3] arm: npcm: add basic support for Nuvoton BMCs
Message-ID: <20171117190747.21642-1-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addressed comments from:
  - Rick (offline comments)
  - Julien: https://www.spinics.net/lists/arm-kernel/msg613222.html
  - Russell: https://www.spinics.net/lists/arm-kernel/msg613212.html
  - Tomer: https://www.spinics.net/lists/arm-kernel/msg614059.html
  - Rob: https://www.spinics.net/lists/arm-kernel/msg613355.html
  - Tomer

Summary of changes since previous update:
  - Arch support:
    - Cleaned up L2C aux values
    - Cleaned up memory barries
    - Renamed CPU_NPCM750 to ARCH_NPCM750
    - Other mostly cosmetic changes
  - DTS:
    - Added property to L2 cache
    - More clean up
  - No changes to MAINTAINERS since v5

Changes have been tested on the NPCM750 evaluation board.
