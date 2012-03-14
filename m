From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2012 13:58:03 +0000
Subject: [PATCH 02/10] ARM: ux500: Initial Device Tree support for Snowball
In-Reply-To: <1331730306-11461-3-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
 <1331730306-11461-3-git-send-email-lee.jones@linaro.org>
Message-ID: <201203141358.03541.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Lee Jones wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This provides very basic Device Tree support for ST-Ericsson's
> low-cost development platform, Snowball. If Device Tree for
> ux500 is enabled and the correct board is configured within the
> Device Tree blob, the correct *_init_machine() will be called.
> 
> This patch is based on some original work completed by:
>   Niklas Hernaeus <niklas.hernaeus@linaro.org>
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Niklas Hernaeus <niklas.hernaeus@linaro.org>

As mentioned on IRC, the order of the S-o-B should be such that the
person submitting a patch comes last, so this one should be

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Niklas Hernaeus <niklas.hernaeus@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

or maybe

Signed-off-by: Niklas Hernaeus <niklas.hernaeus@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

The patch itself looks good to me, but that is not surprising,
given that I wrote it ;-).

	Arnd
