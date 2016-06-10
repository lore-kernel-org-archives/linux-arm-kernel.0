From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 10 Jun 2016 17:47:42 +0200
Subject: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
In-Reply-To: <20160610154414.GE19309@localhost>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160610154414.GE19309@localhost>
Message-ID: <20160610174742.14bd4b3b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 10 Jun 2016 10:44:14 -0500, Bjorn Helgaas wrote:

> If you post a v2 of these, can you align the subject lines of these
> binding, DT, and driver patches so it's easier to find the related
> pieces, e.g., add "Armada 3700" to this one or "Aardvark" to the
> others?  It looks like maybe Aardvark could be used in several
> different systems, so maybe this patch should stay the same and the
> drivers/pci patch should mention Aardvark instead of only "Marvell
> Armada 3700"?

Sure thing. I was about to send a v2, so I've fixed up the commit
titles so that they all include Aardvark.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
