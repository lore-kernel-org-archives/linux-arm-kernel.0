From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 01 May 2014 11:26:39 -0600
Subject: [PATCH v2 04/12] ARM: tegra: add MTD_SPI_NOR (new dependency
 for M25P80)
In-Reply-To: <1398925607-7482-5-git-send-email-computersforpeace@gmail.com>
References: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
 <1398925607-7482-5-git-send-email-computersforpeace@gmail.com>
Message-ID: <536283CF.2020304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2014 12:26 AM, Brian Norris wrote:
> This defconfig contains the CONFIG_M25P80 symbol, which is now
> dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to satisfy
> the new dependency.

Squashed into Tegra's for-3.16/defconfig branch.
