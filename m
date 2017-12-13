From: davem@davemloft.net (David Miller)
Date: Wed, 13 Dec 2017 14:59:40 -0500 (EST)
Subject: [PATCH 2/2] ARM: dts: vf610-zii-dev: use XAUI for DSA link ports
In-Reply-To: <E1eOgsp-0001Ab-9x@rmk-PC.armlinux.org.uk>
References: <E1eOgsp-0001Ab-9x@rmk-PC.armlinux.org.uk>
Message-ID: <20171213.145940.179880807681742911.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Tue, 12 Dec 2017 09:29:51 +0000

> Use XAUI rather than XGMII for DSA link ports, as this is the interface
> mode that the switches actually use. XAUI is the 4 lane bus with clock
> per direction, whereas XGMII is a 32 bit bus with clock.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> This must be applied along with patch 1 to avoid breakage.

Applied.
