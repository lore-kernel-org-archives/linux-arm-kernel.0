From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Tue, 16 Jun 2015 17:05:35 +0000
Subject: [PATCH 2/2] ARM: ep93xx: enable SIM.ONE MMC/SD hardware
In-Reply-To: <1434441531-18647-1-git-send-email-linus.walleij@linaro.org>
References: <1434441531-18647-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D883D4A36A7@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 16, 2015 12:59 AM, Linus Walleij wrote:
> The SIM.ONE has a MMC card connected to the SPI host. This card
> usually hosts an EXT4 root file system. Enable these options in
> the defconfig so the default ompiled kernel will work
> out-of-the-box.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
