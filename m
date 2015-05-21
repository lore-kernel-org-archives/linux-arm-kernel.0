From: davem@davemloft.net (David Miller)
Date: Thu, 21 May 2015 18:57:40 -0400 (EDT)
Subject: [PATCH net-next 0/4] stmmac: probe code refactoring and clean
 up part 1
In-Reply-To: <1432144989-28283-1-git-send-email-manabian@gmail.com>
References: <1432144989-28283-1-git-send-email-manabian@gmail.com>
Message-ID: <20150521.185740.1825645288319421215.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <manabian@gmail.com>
Date: Wed, 20 May 2015 20:03:05 +0200

> This patch set refactor the code in stmmac_pci_probe and stmmac_pltfr_probe
> and moves the common bits into stmmac_dvr_probe. Along the way some clean-
> ups are applied to stmmac_pltfr_probe.
> 
> The code has been tested on the LPC18xx platform.
> 
> I am still working on more refactoring of the platform probe code, hence
> part 1, but I need some more time on this.

Series applied, thank you.
