From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Jun 2016 23:24:36 +0200
Subject: [PATCH v3] ARM: dts: sun7i: Add BCM53125 switch nodes to the
 lamobo-r1 board
In-Reply-To: <1467074756-8402-1-git-send-email-f.fainelli@gmail.com>
References: <1467074756-8402-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160628212436.GH5550@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 05:45:56PM -0700, Florian Fainelli wrote:
> Now that we have a proper binding for Ethernet switches hanging off
> different buses, and a driver for the BCM53125 switch, add its Device
> Tree as a child MDIO node, at MDIO address 30 (Broadcom pseudo-PHY
> address) and describe the ports layout of the Lamobo R1 board.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/a2b51528/attachment.sig>
