From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Dec 2012 09:45:00 +0100
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <20121210082847.GH26922@lunn.ch>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121210082847.GH26922@lunn.ch>
Message-ID: <20121210094500.59d7863c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 10 Dec 2012 09:28:47 +0100, Andrew Lunn wrote:

> pcie_rd_conf, pcie_wr_conf and pci_ops_pcie_ops are common on orion5x,
> dove and kirkwood. Could you maybe factor these functions out and
> place them in plat-orion/pcie.c?

Indeed.

> rc_pci_fixup is also identical for all orion platforms, so is another
> candidate for plat-orion/pcie.c

Sure.

> These are all exact copies, so are easy to cleanup. With more effort
> there is more code which can be refactored and centralized, but that
> is maybe too much work for the moment?

I indeed plan to do more refactoring. In the end, my goal is to have
one single PCIe driver for kirkwood/mvebu/etc, but let's do it step by
step :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
