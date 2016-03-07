From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 7 Mar 2016 09:50:21 +0000
Subject: [PATCH 2/2 v5] irqchip/Layerscape: Add SCFG MSI controller support
In-Reply-To: <1457321782-3245-2-git-send-email-Minghuan.Lian@nxp.com>
References: <1457321782-3245-1-git-send-email-Minghuan.Lian@nxp.com>
 <1457321782-3245-2-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <20160307095021.7f9f7484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Mar 2016 11:36:22 +0800
Minghuan Lian <Minghuan.Lian@nxp.com> wrote:

> Some kind of NXP Layerscape SoC provides a MSI
> implementation which uses two SCFG registers MSIIR and
> MSIR to support 32 MSI interrupts for each PCIe controller.
> The patch is to support it.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

The DT binding still needs an Ack from the DT maintainers though (cc'd).

	M.
-- 
Jazz is not dead. It just smells funny.
