From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Jul 2018 23:10:55 +0200
Subject: [PATCH v2 2/7] net: phy: Fix the register offsets in Broadcom
 iProc mdio mux driver
In-Reply-To: <1532726613-6483-3-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-3-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180728211055.GB4792@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 02:23:28PM -0700, Arun Parameswaran wrote:
> Modify the register offsets in the Broadcom iProc mdio mux to start
> from the top of the register address space.
> 
> Earlier, the base address pointed to the end of the block's register
> space. The base address will now point to the start of the mdio's
> address space. The offsets have been fixed to match this.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
