From: davem@davemloft.net (David Miller)
Date: Wed, 08 Feb 2017 15:48:16 -0500 (EST)
Subject: [PATCH net] net: thunderx: Fix PHY autoneg for SGMII QLM mode
In-Reply-To: <1486557540-818-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1486557540-818-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20170208.154816.2228787443861613018.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Wed,  8 Feb 2017 18:09:00 +0530

> From: Thanneeru Srinivasulu <tsrinivasulu@cavium.com>
> 
> This patch fixes the case where there is no phydev attached
> to a LMAC in DT due to non-existance of a PHY driver or due
> to usage of non-stanadard PHY which doesn't support autoneg.
> Changes dependeds on firmware to send correct info w.r.t
> PHY and autoneg capability.
> 
> This patch also covers a case where a 10G/40G interface is used
> as a 1G with convertors with Cortina PHY in between.
> 
> Signed-off-by: Thanneeru Srinivasulu <tsrinivasulu@cavium.com>
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>

Applied, thanks.
