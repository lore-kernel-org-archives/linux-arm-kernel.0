From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Jun 2017 09:20:14 +0200
Subject: [PATCH v3] arm64: allwinner: a64: Add initial Orangepi
 Win/WinPlus support
In-Reply-To: <1497261194-28815-1-git-send-email-jteki@openedev.com>
References: <1497261194-28815-1-git-send-email-jteki@openedev.com>
Message-ID: <20170613072014.kq3znsh77mncsfyb@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 03:23:13PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Orangepi Win/WinPlus is an open-source single-board computer
> using the Allwinner A64 SOC.
> 
> A64 Orangepi Win/WinPlus has
> - A64 Quad-core Cortex-A53 64bit
> - 1GB(Win)/2GB(Win Plus) DDR3 SDRAM
> - Debug TTL UART
> - Four USB 2.0
> - HDMI
> - LCD
> - Audio and MIC
> - Wifi + BT
> - IR receiver
> - 5V DC power supply
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

You had whitespaces errors in your patch.

I've fixed it, and applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/5f3d36ae/attachment.sig>
