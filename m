From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 6 Jun 2016 16:15:24 +0200
Subject: [PATCH v4 5/7] net: mdio-mux: Add MDIO mux driver for iProc SoCs
In-Reply-To: <1465216900-11755-6-git-send-email-pramod.kumar@broadcom.com>
References: <1465216900-11755-1-git-send-email-pramod.kumar@broadcom.com>
 <1465216900-11755-6-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160606141524.GL2063@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 06:11:38PM +0530, Pramod Kumar wrote:
> iProc based SoCs supports the integrated mdio multiplexer which
> has the bus selection as well as mdio transaction generation logic
> inside.
> 
> This multiplexer has child buses for PCIe, SATA, USB and ETH. These
> buses could be internal or external to SOC where PHYs are attached.
> These buses could use C-45 or C-22 mdio transaction.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

     Andrew
