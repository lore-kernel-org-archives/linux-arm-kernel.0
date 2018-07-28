From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Jul 2018 23:11:43 +0200
Subject: [PATCH v2 3/7] arm64: dts: Fix the base address of the Broadcom
 iProc mdio mux
In-Reply-To: <1532726613-6483-4-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-4-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180728211143.GC4792@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 02:23:29PM -0700, Arun Parameswaran wrote:
> Modify the base address of the mdio mux driver to point to the
> start of the mdio mux block's register address space.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
