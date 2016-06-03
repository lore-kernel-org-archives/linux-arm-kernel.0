From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 3 Jun 2016 18:15:44 +0200
Subject: [PATCH v3 3/7] binding: mdio-mux: Add DT binding doc for
 Broadcom MDIO bus mutiplexer
In-Reply-To: <1464967568-27562-4-git-send-email-pramod.kumar@broadcom.com>
References: <1464967568-27562-1-git-send-email-pramod.kumar@broadcom.com>
 <1464967568-27562-4-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160603161544.GF22120@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +Properties for an MDIO bus mutiplexer found in Broadcom iProc based SoCs.
> +
> +This MDIO bus multiplexer defines buses that could be internal as well as
> +external to SoCs and could accept MDIO transaction compatible to C-22 or
> +C-45 Clause. When child bus is selected, one needs to select these two
> +properties as well to generate desired MDIO trascation on appropriate bus.
> +

nit pick: transactions

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

	     Andrew
