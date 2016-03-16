From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Mar 2016 11:08:57 +0100
Subject: [PATCH 2/2] PCI: mvebu: use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for
 mvebu_pcie_pm_ops
In-Reply-To: <1458122381-2280-3-git-send-email-jszhang@marvell.com>
References: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
 <1458122381-2280-3-git-send-email-jszhang@marvell.com>
Message-ID: <20160316110857.406e0662@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jisheng Zhang,

On Wed, 16 Mar 2016 17:59:41 +0800, Jisheng Zhang wrote:
> use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS helper macro for mvebu_pcie_pm_ops.
> The macro also setups freeze_noirq, thaw_noirq and poweroff_noirq,
> restore_noirq accordingly.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
