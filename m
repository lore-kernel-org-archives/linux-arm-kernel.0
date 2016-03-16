From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Mar 2016 11:07:24 +0100
Subject: [PATCH 1/2] PCI: mvebu: constify mvebu_pcie_pm_ops structure
In-Reply-To: <1458122381-2280-2-git-send-email-jszhang@marvell.com>
References: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
 <1458122381-2280-2-git-send-email-jszhang@marvell.com>
Message-ID: <20160316110724.239fd419@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jisheng Zhang,

On Wed, 16 Mar 2016 17:59:40 +0800, Jisheng Zhang wrote:
> The mvebu_pcie_pm_ops structure is never modified, so declare it as
> const.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
