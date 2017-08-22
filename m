From: brendanhiggins@google.com (Brendan Higgins)
Date: Mon, 21 Aug 2017 20:34:59 -0700
Subject: [PATCH v1 0/3] arm: npcm: add basic support for Nuvoton BMCs
Message-ID: <20170822033502.4100-1-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the Nuvoton NPCM Baseboard Management Controller
(BMC) SoC architecture as well as the NPCM750 variant. NPCM is an ARM based SoC
with external DDR RAM and supports a large set of peripherals.

The NPCM750 is based on Cortex A9 and comes in single core and dual core
flavors.

The device tree added in this patchset has a number of bindings for which the
corresponding drivers will be sent out later and thus do not yet have binding
documentation. Apologies in advance if you would like the bindings to be added
along with the corresponding drivers.

Thanks!
