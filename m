From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Jun 2017 16:52:36 +0200
Subject: [PATCH] arm64: allwinner: a64: Add initial NanoPi A64 support
In-Reply-To: <1497013436-14107-1-git-send-email-jteki@openedev.com>
References: <1497013436-14107-1-git-send-email-jteki@openedev.com>
Message-ID: <20170609145236.tunnjyiorfggyhk5@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 01:03:56PM +0000, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> NanoPi A64 is a new board of high performance with low cost
> designed by FriendlyElec., using the Allwinner A64 SOC.
> 
> Nanopi A64 features
> - Allwinner A64, 64-bit Quad-core Cortex-A53 at 648MHz to 1.152GHz, DVFS
> - 1GB DDR3 RAM
> - MicroSD
> - Gigabit Ethernet (RTL8211E)
> - Wi-Fi 802.11b/g/n
> - IR receiver
> - Audio In/Out
> - Video In/Out
> - Serial Debug Port
> - microUSB 5V 2A DC power-supply
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Hmmm, I'm confused, didn't you just send that DT already?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/08ed8d59/attachment.sig>
