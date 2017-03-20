From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 09:29:56 +0100
Subject: [PATCH] ARM: dts: sun7i: lamobo-r1: Fix CPU port RGMII settings
In-Reply-To: <20170319045321.6454-1-f.fainelli@gmail.com>
References: <20170319045321.6454-1-f.fainelli@gmail.com>
Message-ID: <20170320082956.sa2bwsoapp23srto@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Sat, Mar 18, 2017 at 09:53:20PM -0700, Florian Fainelli wrote:
> The CPU port of the BCM53125 is configured with RGMII (no delays) but
> this should actually be RGMII with transmit delay (rgmii-txid) because
> STMMAC takes care of inserting the transmitter delay. This fixes
> occasional packet loss encountered.
> 
> Fixes: d7b9eaff5f0c ("ARM: dts: sun7i: Add BCM53125 switch nodes to the lamobo-r1 board")
> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/59cf06e2/attachment.sig>
