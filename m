From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 13 May 2017 11:26:20 -0700
Subject: [PATCH 2/4] ARM: ep93xx: simone: let the mmc_spi driver handle
 the card detect
In-Reply-To: <20170221181529.6780-3-hsweeten@visionengravers.com>
References: <20170221181529.6780-1-hsweeten@visionengravers.com>
 <20170221181529.6780-3-hsweeten@visionengravers.com>
Message-ID: <e8f46547-1251-b93f-f187-ef80a6bffad7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/21/17 ? 10:15, H Hartley Sweeten a ?crit :
> This board uses a GPIO for the MMC card detect. Let the mmc_spi
> driver handle it instead of the platform code.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
