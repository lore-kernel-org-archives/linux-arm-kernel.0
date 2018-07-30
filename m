From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Jul 2018 20:04:04 +0200
Subject: [PATCH v2 6/7] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <d19bb673-9088-bbee-ce9f-f2a4d8f404bf@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
 <20180728212224.GF4792@lunn.ch>
 <d19bb673-9088-bbee-ce9f-f2a4d8f404bf@broadcom.com>
Message-ID: <20180730180404.GH2983@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hi Arun
> > 
> > There is a devm_mdiobus_alloc() which could make the cleanup on error
> > simple.
> > 
> Should I do this as a separate patch ?

A separate patch is easier to review. And if something breaks, a git
bisect gives you a better idea what actually broke it, if you have
lots of small patches.

     Andrew
