From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Mar 2010 10:57:31 -0700
Subject: [PATCH] arm: Fix mounting root on omaps with CPU_V6 and CPU_V7
Message-ID: <20100317175731.GE2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's an updated version of this patch with more details.

Looks like VFPv3 is only available on V7:

http://www.arm.com/products/processors/technologies/vector-floating-point.php

HAS_TLS reg is only on ARM11 starting with r1p0:

http://infocenter.arm.com/help/topic/com.arm.doc.ddi0211k/Babeihid.html

So that explains why it won't work on omap2420 as it's r0p2.

Regards,

Tony
