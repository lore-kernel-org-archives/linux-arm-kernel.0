From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 May 2014 14:12:31 -0700
Subject: [PATCH] ARM: OMAP: SX1: remove check for CONFIG_SX1_OLD_FLASH
In-Reply-To: <1400182902.11786.21.camel@x220>
References: <1400182902.11786.21.camel@x220>
Message-ID: <20140516211231.GF12881@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Bolle <pebolle@tiscali.nl> [140515 12:42]:
> A check for CONFIG_SX1_OLD_FLASH was added in v2.6.24. But the related
> Kconfig symbol was never part of the tree. So we can remove some dead
> code.

Thanks applying into omap-for-v3.16/board.

Tony
