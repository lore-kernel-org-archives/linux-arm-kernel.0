From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 1 Nov 2013 10:12:56 +0000
Subject: [PATCH 0/2] DT: correctly describe GIC400 virtualisation regions
Message-ID: <1383300776.4332.3.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several existing platforms which sport an A15 compatible GIC to not
include the extended GIC cpu interface regisiters in their device tree.
Fix these.

Also extend the bindings to cope with cpu intefface registers which are
not in contiguous pages.

Ian.
