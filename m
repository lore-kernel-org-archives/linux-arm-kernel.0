From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 06 Aug 2017 18:14:20 +0300
Subject: [PATCH v2 0/2] OMAP3+/4+ PRM: fix of_irq_get() result checks
Message-ID: <20170806151420.104225294@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against the 'omap-for-v4.13/fixes' branch of Tony
Lingren's 'linux-omap.git' repo.  I'm  fixing of_irq_get() DT API result
checks.

[1/2] ARM: OMAP3+: PRM: fix of_irq_get() result check
[2/2] ARM: OMAP4+: PRM: fix of_irq_get() result checks

MBR, Sergei
