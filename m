From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 15:40:16 +0000
Subject: [PATCH v3 09/10] pwm: Add PXA support
In-Reply-To: <1329923841-32017-10-git-send-email-thierry.reding@avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-10-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <201202221540.16897.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2012, Thierry Reding wrote:
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Changes in v3:
>   - update PWM ops for changes in patch 2
> 
>  arch/arm/plat-pxa/Makefile |    1 -
>  arch/arm/plat-pxa/pwm.c    |  304 --------------------------------------------
>  drivers/pwm/Kconfig        |    9 ++
>  drivers/pwm/Makefile       |    1 +
>  drivers/pwm/pwm-pxa.c      |  244 +++++++++++++++++++++++++++++++++++
>  5 files changed, 254 insertions(+), 305 deletions(-)
>  delete mode 100644 arch/arm/plat-pxa/pwm.c
>  create mode 100644 drivers/pwm/pwm-pxa.c

Since most of this patch is a move of one file, it would help to use the -M
flag to git-format-patch so we can see the actual change.

To make it even more explicit, you could separate the patches that move the
files around from the ones that convert the drivers to the new API.

	Arnd
