From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 3 Jun 2016 18:29:40 +0200
Subject: [PATCH v3 7/7] phy: Add Northstar2 PCI Phy support
In-Reply-To: <1464967568-27562-8-git-send-email-pramod.kumar@broadcom.com>
References: <1464967568-27562-1-git-send-email-pramod.kumar@broadcom.com>
 <1464967568-27562-8-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160603162940.GH22120@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 08:56:08PM +0530, Pramod Kumar wrote:
> Add PCI Phy support for Broadcom Northstar2 SoCs.  This driver uses the
> interface from the iproc mdio mux driver to enable the devices
> respective phys.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Andrew	     
