From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 1 Jun 2016 12:26:33 -0700
Subject: [PATCH] ARM: BCM5301X: Enable SPI-NOR on dual flash devices
In-Reply-To: <1461740704-21501-1-git-send-email-zajec5@gmail.com>
References: <1461740704-21501-1-git-send-email-zajec5@gmail.com>
Message-ID: <574F36E9.6030400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 12:05 AM, Rafa? Mi?ecki wrote:
> Commit 1b47b98acce2 ("ARM: BCM5301X: Add DT entry for SPI controller and
> NOR flash") enabled SPI-NOR device on routers using serial flash only.
> However there are also devices with two flash memories:
> 1) Small SPI attached flash used mostly for booting
> 2) Bigger NAND used mostly for storing firmware
> On such devices we still need SPI-NOR e.g. to access NVRAM data.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Applied, thanks!
--
Florian
