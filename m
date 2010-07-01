From: andi@firstfloor.org (Andi Kleen)
Date: Thu, 1 Jul 2010 20:02:41 +0200
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <20100701101746.3810cc3b.randy.dunlap@oracle.com>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
Message-ID: <20100701180241.GA3594@basil.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What license (name/type) is this?

IANAL, but AFAIK standard wisdom is that "disclaimer in the documentation
and/or other materials provided" is generally not acceptable for Linux
because it's an excessive burden for all distributors.

Also for me it's still quite unclear why we would want this code at all...
It doesn't seem to do anything you couldn't do with the existing interfaces.

-Andi
