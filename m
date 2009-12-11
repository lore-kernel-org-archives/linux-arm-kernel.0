From: abhijitpagare@ti.com (Pagare, Abhijit)
Date: Fri, 11 Dec 2009 16:40:19 +0530
Subject: [PATCH 0/5] OMAP4 Clock Domain Framework Support
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC14197B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for OMAP4 clock domain framework.

It can be applied on top of the latest Mainline Kernel but has a dependency on OMAP4 power domain framework patches sent by me earlier.

These patches have been boot-tested on the following platforms:
-OMAP4 simulator
-OMAP4430 ES1.0 silicon
-OMAP3430 SDP

In addition to this these patches have been compile-tested for the following platforms:
-omap_2430sdp
-omap_h4_2420sdp

The complete omap4 clock domain structure is auto-generated using OMAP4 hardware database and is a joint effort of Paul Walmsley (paul at pwsan.com), Benoit Cousson (b-cousson at ti.com), Rajendra Nayak (rnayak at ti.com) and me.


Best Regards,
Abhijit Pagare

ARM: OMAP4: PM: Make OMAP3 Clock-domain framework compatible for OMAP4.
ARM: OMAP4: PM: Modify Clock-domain interfaces for OMAP4 compatibility.
ARM: OMAP4: PM: Add the Auto-generated OMAP4 specific clock domain framework.
ARM: OMAP4: PM: Adapt the existing OMAP2/3 Clock Domain Frameworks.
ARM: OMAP4: PM: Refine the APIs to support OMAP4 features.
