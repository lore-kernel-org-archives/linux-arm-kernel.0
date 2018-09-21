From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 21 Sep 2018 14:59:33 -0700
Subject: [PATCH] ARM: BCM63XX: Fix incorrect interrupt specifiers
In-Reply-To: <20180920001402.1585-1-f.fainelli@gmail.com>
References: <20180920001402.1585-1-f.fainelli@gmail.com>
Message-ID: <20180921215933.8592-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Sep 2018 17:14:01 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> A number of our interrupts were incorrectly specified, fix both the PPI
> and SPI interrupts to be correct.
> 
> Fixes: b5762cacc411 ("ARM: bcm63138: add NAND DT support")
> Fixes: 46d4bca0445a ("ARM: BCM63XX: add BCM63138 minimal Device Tree")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
