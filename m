From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 16 Jul 2016 18:39:13 +0200
Subject: [PATCH v0 06/10] arm: orion5x: Add DT-based support for Netgear
 WNR854T
In-Reply-To: <1468679348-10522-7-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1468679348-10522-7-git-send-email-jm@lentin.co.uk>
Message-ID: <20160716163913.GI1777@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	pmx_reset_switch: pmx-reset-switch {
> +		marvell,pins = "mpp1";
> +		marvell,function = "gpio";
> +	};

Ah! I think i interpreted that wrong. This does not reset the Ethernet
switch. It is actually a switch on the front to reset the whole box?

How about calling it button, not switch?

    Andrew
