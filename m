From: davem@davemloft.net (David Miller)
Date: Fri, 10 Jun 2016 23:27:08 -0700 (PDT)
Subject: [PATCH v5 0/7] Add MDIO bus multiplexer support for iProc SoCs
In-Reply-To: <1465536831-13023-1-git-send-email-pramod.kumar@broadcom.com>
References: <1465536831-13023-1-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160610.232708.520435980652214195.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pramod Kumar <pramod.kumar@broadcom.com>
Date: Fri, 10 Jun 2016 11:03:44 +0530

> Broadcom iProc based SoCs use a MDIO bus multiplexer where child buses
> could be internal as well external to SoCs. These buses could supports
> MDIO transaction compatible to C-22/C-45.
> 
> Broadcom MDIO bus multiplexer is an integrated multiplexer where child bus
> selection and mdio transaction logic lies inside multiplexer itself.
> To accommodate this multiplexer in existing mux framework below changes
> were required-
> 
> 1. Passed MDIO parent bus via mdio_mux_init to MDIO mux framework.
> 
> This patch set includes MDIO bus multiplexer driver along with above
> framework change. It includes one external bus node having Ethernet PHY
> attached and two internal bus node holding PCIe PHYs.
 ...

Series applied, thanks.
