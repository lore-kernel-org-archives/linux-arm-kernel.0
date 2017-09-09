From: brendanhiggins@google.com (Brendan Higgins)
Date: Fri,  8 Sep 2017 18:53:05 -0700
Subject: [PATCH v5 0/3] arm: npcm: add basic support for Nuvoton BMCs
Message-ID: <20170909015308.30001-1-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addressed comments from:
  - kbuild robot: https://www.spinics.net/lists/arm-kernel/msg605356.html
  - kbuild robot: https://www.spinics.net/lists/arm-kernel/msg605325.html

Changes since previous update:
  - Addressed some minor issues caught by build bot, no structural changes.
  - Changes status of NPCM MAINTAINERS entry to Supported since Avi and Tomer
    are paid to do this.
  - No changes to device tree since v4

Changes have been tested on the NPCM750 evaluation board.
