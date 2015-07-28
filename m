From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 28 Jul 2015 12:20:25 +1000
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20150728122025.6b2cdbc8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/arm/mach-shmobile/intc-sh73a0.c

between commit:

  30f8925a57d8 ("ARM: shmobile: Remove legacy board code for KZM-A9-GT")

from the arm-soc tree and commit:

  0d3f2c92e004 ("irqchip/gic: Remove redundant gic_set_irqchip_flags")

from the tip tree.

I fixed it up (I just removed the file) and can carry the fix as necessary
(no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
