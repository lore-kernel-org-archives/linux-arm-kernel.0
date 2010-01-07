From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 07 Jan 2010 14:39:21 +1100
Subject: [PATCH 0/3] Base patches for ARM devicetree groundwork
Message-ID: <1262835561.887063.943450380979.0.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

As requested, these are the non-DT-specific patches from my DT series,
rebased onto the current branch. The first patch may be useful on its
own, the other two are only really needed for the DT work.

Cheers,


Jeremy

---
Jeremy Kerr (3):
      arm: use generic infrastructure for early params
      arm: change command_line to cmd_line, and export it
      arm: export arm_add_memory
