From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 7 Jan 2010 09:31:00 +1100
Subject: [PATCH 02/11] arm: use generic infrastructure for early params
In-Reply-To: <20100106162731.GB1728@n2100.arm.linux.org.uk>
References: <1261479296.245235.191110925832.0.gpush@pororo>
	<1261479296.246097.171417450949.2.gpush@pororo>
	<20100106162731.GB1728@n2100.arm.linux.org.uk>
Message-ID: <201001070931.00811.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

> This is something which should be separate from the rest of the DT
> patch - could we have this as a patch which can be applied to the
> current kernel tree please?

Sure, patch coming.

The first three patches of this series (prefixed with arm:, rather than arm-
dt:) are all generic arm patches that don't specifically add device tree 
support, would you like the other two as well?

I'm in the process of rebasing my work onto a merge or your and Grant Likely's 
test-devicetree branch, so future patches should be easier to work with.

Cheers,


Jeremy
