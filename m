From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2016 17:17:29 +0100
Subject: [PATCH 2/2] ARM: dts: imx6: tag boards that have the HW
 workaround for ERR006687
In-Reply-To: <1464794983-31484-3-git-send-email-l.stach@pengutronix.de>
References: <1464794983-31484-1-git-send-email-l.stach@pengutronix.de>
 <1464794983-31484-3-git-send-email-l.stach@pengutronix.de>
Message-ID: <20160601161729.GB19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 05:29:43PM +0200, Lucas Stach wrote:
> @@ -97,6 +97,7 @@
>  	phy-reset-gpios = <&gpio3 31 0>;
>  	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
>  			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
> +	fsl,err006687-war-present;

war?  Any reason not to spell it out, or use the more natural
abbreviation "wa"?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
