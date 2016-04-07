From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 7 Apr 2016 11:54:01 -0500
Subject: [PATCH 0/2] PCI: mvebu: trivial cleanup
In-Reply-To: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
References: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160407165400.GD8780@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 05:59:39PM +0800, Jisheng Zhang wrote:
> trivial clean ups to pci-mvebu.c
> 
> Jisheng Zhang (2):
>   PCI: mvebu: constify mvebu_pcie_pm_ops structure
>   PCI: mvebu: use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for mvebu_pcie_pm_ops

Applied with Thomas' ack to pci/host-mvebu for v4.7, thanks!
