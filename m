From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Jul 2018 21:20:50 +0200
Subject: [PATCH 7/7] net: phy: Add pm support for scan ctrl register to
 bcm mdio mux
In-Reply-To: <1532630184-29450-8-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-8-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180726192050.GJ10686@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 11:36:24AM -0700, Arun Parameswaran wrote:
> Add support for saving and restoring the 'scan control' register
> in the Broadcom iProc mdio mux driver.

Hi Arun

I don't see anything setting this register. So why is it necessary to
save it over suspend/resume?

     Andrew
