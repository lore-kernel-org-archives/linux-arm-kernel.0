From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 26 Oct 2014 00:18:27 +0200
Subject: [PATCHv0] arm: mvebu: add .dts file for Synology DS213j
In-Reply-To: <3d0cc6de9ea5506d5fb201129ad277e57d0cdfc8.1414268057.git.arno@natisbad.org>
References: <3d0cc6de9ea5506d5fb201129ad277e57d0cdfc8.1414268057.git.arno@natisbad.org>
Message-ID: <20141025221827.GB14620@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/ {
> +	model = "Synology DS213j";
> +	compatible = "synology,ds213j", "marvell,armada370", "marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};
> +


Missed it on the first look through. To help barebox, it is good to
have:

               stdout-path = &uart0;

       Andrew
