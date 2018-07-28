From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Jul 2018 23:09:22 +0200
Subject: [PATCH v2 1/7] dt-bindings: net: Fix Broadcom iProc mdio mux
 driver base address
In-Reply-To: <1532726613-6483-2-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-2-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180728210922.GA4792@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 02:23:27PM -0700, Arun Parameswaran wrote:
> Modify the base address of the Broadcom iProc MDIO mux driver to
> point to the start of the block's register address space.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
