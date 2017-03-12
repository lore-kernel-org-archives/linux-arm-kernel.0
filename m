From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 12 Mar 2017 18:10:32 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add support for TP-LINK Archer C5 V2
In-Reply-To: <20170311121453.18534-1-zajec5@gmail.com>
References: <20170311121453.18534-1-zajec5@gmail.com>
Message-ID: <20170312171032.GK15842@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlycon";

Using bootargs to pass the serial settings has been deprecated for a
while. Please use stdout-path instead.

       Andrew
