From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 10 Jun 2016 10:44:14 -0500
Subject: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
In-Reply-To: <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160610154414.GE19309@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 11:09:43AM +0200, Thomas Petazzoni wrote:
> This commit adds the documentation for the Device Tree binding used to
> describe the Aardvark PCIe controller, found on Marvell Armada 3700
> ARM64 SoCs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Thomas,

If you post a v2 of these, can you align the subject lines of these
binding, DT, and driver patches so it's easier to find the related
pieces, e.g., add "Armada 3700" to this one or "Aardvark" to the
others?  It looks like maybe Aardvark could be used in several
different systems, so maybe this patch should stay the same and the
drivers/pci patch should mention Aardvark instead of only "Marvell
Armada 3700"?

Bjorn
