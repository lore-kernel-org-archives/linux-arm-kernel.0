From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Jul 2018 23:13:15 +0200
Subject: [PATCH v2 4/7] net: phy: Disable external master access in bcm
 mdio mux driver
In-Reply-To: <1532726613-6483-5-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-5-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180728211315.GD4792@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 02:23:30PM -0700, Arun Parameswaran wrote:
> Configure the scan control register in the Broadcom iProc
> mdio mux driver to disable access to external master.
> 
> In some SoC's, the scan control register defaults to an incorrect
> value.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
