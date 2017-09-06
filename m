From: brendanhiggins@google.com (Brendan Higgins)
Date: Tue,  5 Sep 2017 17:30:13 -0700
Subject: [PATCH v3 0/3] arm: npcm: add basic support for Nuvoton BMCs
Message-ID: <20170906003016.2159-1-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addressed comments from:
  - Florian: https://www.spinics.net/lists/arm-kernel/msg604948.html

Changes since previous update:
  - Substanitally simplified the SMP code for NPCM750.
  - No changes to device tree or MAINTAINERS since v2

Changes have been tested on the NPCM750 evaluation board.
