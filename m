From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Sep 2017 14:27:16 +0200
Subject: [PATCH 0/6] staging: Introduce DPAA2 Ethernet Switch driver
In-Reply-To: <1505811698-7338-1-git-send-email-razvan.stefanescu@nxp.com>
References: <1505811698-7338-1-git-send-email-razvan.stefanescu@nxp.com>
Message-ID: <20170919122716.GC4569@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 12:01:32PM +0300, Razvan Stefanescu wrote:
> This patchset introduces the Ethernet Switch Driver for Freescale/NXP SoCs
> with DPAA2 (DataPath Acceleration Architecture v2). The driver manages
> switch objects discovered on the fsl-mc bus. A description of the driver
> can be found in the associated README file.

Hi Razvan

You should probably Cc: netdev with these patches, if you want people
who have written switch drivers to review you code. You can also drop
linux-arm-kernel, since there is nothing ARM specific in these
patches.

	Andrew
