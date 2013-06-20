From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 22:28:42 +0200
Subject: [GIT PULL 07/10] Samsung S3C24XX PINCTRL-2 for v3.11
In-Reply-To: <51C0BC6B.2080507@samsung.com>
References: <51C0BC6B.2080507@samsung.com>
Message-ID: <201306202228.42435.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Kukjin Kim wrote:
> The following changes since commit af99a7507469d4fa6dd4d8d633e093b1ff7aff6e:
> 
>    pinctrl: Add pinctrl-s3c24xx driver (2013-05-21 00:56:13 +0900)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/s3c24xx-pinctrl-2
> 
> for you to fetch changes up to c2c70a7905dbf97472e9a5fa6919675462373994:
> 
>    pinctrl: s3c24xx: use correct header for chained_irq functions 
> (2013-06-19 02:41:20 +0900)
> 
> ----------------------------------------------------------------
> based on s3c24xx-pinctrl
> - use correct header for chained_irq functions for s3c24xx-pinctrl
> 
> ----------------------------------------------------------------
> Heiko Stuebner (1):
>        pinctrl: s3c24xx: use correct header for chained_irq functions
> 
>   drivers/pinctrl/pinctrl-s3c24xx.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

Pulled into next/drivers, thanks!

	Arnd
