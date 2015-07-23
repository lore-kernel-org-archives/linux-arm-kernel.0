From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 23 Jul 2015 08:18:32 -0500
Subject: [PATCH v5 00/19] Per-device MSI domain & platform MSI
In-Reply-To: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150723131832.GW21967@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 10:26:19AM +0100, Marc Zyngier wrote:
> MSI-like interrupts are starting to creep out of the PCI world, and
> can now be seen into a number of "platform"-type busses. The
> introduction of the MSI domains feature in v3.19 recognised that fact,
> and started providing a way to implement this.
> ...

The PCI parts all look great to me.  I assume Thomas will merge the whole
thing through his tree.  Thanks!

Bjorn
