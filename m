From: tony@atomide.com (Tony Lindgren)
Date: Thu, 08 Jul 2010 13:08:05 +0300
Subject: [PATCH 0/5] omap serial init patches for 2.6.36 merge window
Message-ID: <20100708100715.19285.30066.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some patches dealing with omap serial errata handling.

Regards,

Tony

---

Deepak K (1):
      omap2/3/4: serial: errata i202: fix for MDR1 access

Govindraj R (1):
      omap3: serial: Add context save and restore for mcr

Nishanth Menon (3):
      omap2/3/4: serial: remove initialization sparse warnings
      omap2/3/4: serial: kill dev_attr_sleep_timeout sparse warn
      omap2/3/4: serial: introduce errata handling


 arch/arm/mach-omap2/serial.c |   80 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 69 insertions(+), 11 deletions(-)

-- 
Signature
