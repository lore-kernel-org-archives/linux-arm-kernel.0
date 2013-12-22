From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 22 Dec 2013 12:21:49 -0500
Subject: [PATCH 4/4] Phy: Add DT nodes on kirkwood and Dove for the
 SATA PHY
In-Reply-To: <1387311713-1926-4-git-send-email-andrew@lunn.ch>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-4-git-send-email-andrew@lunn.ch>
Message-ID: <20131222172149.GJ2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 09:21:52PM +0100, Andrew Lunn wrote:
> Add nodes for the two SATA PHYs on kirkwood.
> Add node for the one SATA PHY on Dove.
> Add pHandles to the PHYs in the sata nodes.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v1->v2:
> sata_phy at ... ->sata-phy@
> value after '@' matching the first address in the reg.
> 
> v2->v3:
> "0" -> "port0", etc.
> kirkewood -> kirkwood
> ---
>  arch/arm/boot/dts/dove.dtsi          | 11 +++++++++++
>  arch/arm/boot/dts/kirkwood-6281.dtsi |  2 ++
>  arch/arm/boot/dts/kirkwood-6282.dtsi |  2 ++
>  arch/arm/boot/dts/kirkwood.dtsi      | 18 ++++++++++++++++++
>  4 files changed, 33 insertions(+)

Applied to mvebu/dt with Kishon's Ack.

Please double check me, I had to shuffle dove.dtsi since I recently
sorted the nodes under the ocp bus.

thx,

Jason.
