From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 2 Feb 2018 23:51:53 +0100
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer for sama5d34ek
In-Reply-To: <20180124212346.3823-1-brgl@bgdev.pl>
References: <20180124212346.3823-1-brgl@bgdev.pl>
Message-ID: <20180202225153.GK3404@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/2018 at 22:23:46 +0100, Bartosz Golaszewski wrote:
> Using compatible strings without the <manufacturer> part for at24 is
> now deprecated. Use a correct 'atmel,<model>' value.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  arch/arm/boot/dts/sama5d34ek.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

I forgot to reply but I applied all of them for 4.17, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
