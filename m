From: brendanhiggins@google.com (Brendan Higgins)
Date: Wed,  6 Sep 2017 01:07:48 -0700
Subject: [PATCH v4 0/3] arm: npcm: add basic support for Nuvoton BMCs
Message-ID: <20170906080751.6773-1-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addressed comments from:
  - Joel: https://www.spinics.net/lists/arm-kernel/msg605137.html

Changes since previous update:
  - Added SMP and SMP_ON_UP
  - Changed dts to use phandle
