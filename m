From: abhijitpagare@ti.com (Pagare, Abhijit)
Date: Fri, 11 Dec 2009 16:15:59 +0530
Subject: [PATCH 0/5] OMAP4 Power Domain Framework Support
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC14194C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for OMAP4 power domain framework.

It can be applied on top of the latest Mainline Kernel.

These patches have been boot-tested on the following platforms:
-OMAP4 simulator
-OMAP4430 ES1.0 silicon
-OMAP3430 SDP

In addition to this these patches have been compile-tested for the following platforms:
-omap_2430sdp
-omap_h4_2420sdp

The complete omap4 power domain structure is auto-generated using OMAP4 hardware database and is a joint effort of Paul Walmsley (paul at pwsan.com), Benoit Cousson (b-cousson at ti.com), Rajendra Nayak (rnayak at ti.com) and me.


Best Regards,
Abhijit Pagare


Abhijit Pagare (5):
ARM: OMAP4: PM: OMAP4 essential basic initializations.
ARM: OMAP4: PM: OMAP4 Power Domain Porting Related Clean-up.
ARM: OMAP4: PM: Add the Auto-generated OMAP4 specific power domain framework.
ARM: OMAP4: PM: Adapt the existing OMAP2/3 and common Power Domain Frameworks.
ARM: OMAP4: PM: Refine the APIs to support OMAP4 features.
