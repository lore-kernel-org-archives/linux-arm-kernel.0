From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 11 Jan 2017 11:33:03 +0100
Subject: [PATCH] PCI/MSI: pci-xgene-msi: Fix CPU hotplug registration
 handling
In-Reply-To: <1484130407-24707-1-git-send-email-marc.zyngier@arm.com>
References: <1484130407-24707-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20170111103303.5cu4m2f66arucgyp@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-01-11 10:26:47 [+0000], Marc Zyngier wrote:
> The conversion to the new hotplug state machine introduced a regression
> where a successful hotplug registration would be treated as an error,
> effectively disabling the MSI driver forever.
> 
> Fix it by doing the proper check on the return value.
> 
> Fixes: 9c248f8896e6 ("PCI/xgene-msi: Convert to hotplug state machine")
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
