From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 06 Jun 2015 16:14:22 -0700
Subject: [PATCH] ARM: BCM5301X: add IRQ numbers for PCIe controller
In-Reply-To: <1432494494-13361-1-git-send-email-hauke@hauke-m.de>
References: <1432494494-13361-1-git-send-email-hauke@hauke-m.de>
Message-ID: <55737ECE.3080500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/24/15 12:08, Hauke Mehrtens a ?crit :
> The driver for the PCIe controller was just added, this adds the
> missing definition of the IRQ numbers to device tree. The driver itself
> will be automatically detected by bcma.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied to devicetree/next, thanks!
-- 
Florian
