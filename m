From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 23 Jun 2010 18:24:38 -0600
Subject: [PATCH] OMAP: hwmod regression fix for 2.6.35-rc
Message-ID: <20100624002249.12347.37548.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch (intended for 2.6.35-rc) fixes a bad regression in
2.6.35-rc preventing the hwmod code from working.


- Paul


---

Benoit Cousson (1):
      OMAP: hwmod: Fix the missing braces


 arch/arm/mach-omap2/omap_hwmod.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)
