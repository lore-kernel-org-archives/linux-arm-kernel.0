From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Sep 2012 11:25:00 -0600
Subject: [PATCH 1/3] ARM: Remove bcmring NAND driver
In-Reply-To: <505044E3.3040601@broadcom.com>
References: <505044E3.3040601@broadcom.com>
Message-ID: <5050C56C.8070603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 02:16 AM, Christian Daudt wrote:
> This driver is being removed as part of the cleanup of the bcmring
> SoC from mainline as it is no longer maintained.

>  arch/arm/configs/bcmring_defconfig |    2 -

Out of curiosity, if you're removing the whole thing, why edit the
defconfig at all; just delete it instead in whatever patch removes the
arch/arm parts?
