From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Aug 2014 13:26:10 -0600
Subject: [PATCH] arm: tegra: apalis/colibri t30: fix on-module 5v0 supplies
In-Reply-To: <cbf0902cd98332bc0218d84fd055b42fab3ea3b2.1408719375.git.marcel@ziswiler.com>
References: <cbf0902cd98332bc0218d84fd055b42fab3ea3b2.1408719375.git.marcel@ziswiler.com>
Message-ID: <53F79952.6060002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2014 09:06 AM, Marcel Ziswiler wrote:
> Working on Gigabit/PCIe support in U-Boot for Apalis T30 I realised
> that the current device tree source includes for our modules only
> happen to work due to referencing the on-carrier 5v0 supply from USB
> which is not at all available on-module. The modules actually contain
> TPS60150 charge pumps to generate the PMIC required 5 volts from the
> one and only 3.3 volt module supply. This patch fixes this.

I've forwarded this to the ARM SoC maintainers as a fix for v3.17.
