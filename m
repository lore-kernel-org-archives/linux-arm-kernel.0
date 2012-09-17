From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 14:28:44 +0800
Subject: [PATCH] ARM: dts: mxs: Add ethernetX to macX aliases
In-Reply-To: <1347535402-17148-1-git-send-email-marex@denx.de>
References: <1347535402-17148-1-git-send-email-marex@denx.de>
Message-ID: <20120917062842.GA6413@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 01:23:22PM +0200, Marek Vasut wrote:
> Add ethernet0 and ethernet1 aliases into the imx28.dtsi file, as
> that is what most bootloaders use to pass MAC address. The bootloader
> seeks for this alias and adds "mac-address" and "local-mac-address"
> properties to the aliased node. This fixes issues with FEC having
> NULL MAC address when update_fec_mac_prop() wasn't called. And
> not all boards call update_fec_mac_prop() .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.
