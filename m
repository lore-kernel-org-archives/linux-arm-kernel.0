From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 01 Jul 2010 12:28:23 -0700
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <20100701180241.GA3594@basil.fritz.box>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<20100701180241.GA3594@basil.fritz.box>
Message-ID: <1278012503.7738.17.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-01 at 20:02 +0200, Andi Kleen wrote:
> > What license (name/type) is this?
> 
> IANAL, but AFAIK standard wisdom is that "disclaimer in the documentation
> and/or other materials provided" is generally not acceptable for Linux
> because it's an excessive burden for all distributors.

It's the BSD license ..

> Also for me it's still quite unclear why we would want this code at all...
> It doesn't seem to do anything you couldn't do with the existing interfaces.

I don't know all that much about what Zach's done here, but from what
he's said so far it looks like this help to manage lots of IOMMUs on a
single system.. On x86 it seems like there's not all that many IOMMUs in
comparison .. Zach mentioned 10 to 100 IOMMUs ..

Daniel

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
