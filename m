From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 18 Mar 2015 18:58:09 -0700
Subject: [PATCH 35/35 linux-next] pinctrl: constify of_device_id array
In-Reply-To: <1426535949-26107-4-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-4-git-send-email-fabf@skynet.be>
Message-ID: <1426730289.21744.7.camel@mussux00.eus.mediatek.inc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-16 at 20:59 +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  drivers/pinctrl/bcm/pinctrl-bcm2835.c       | 2 +-
>  drivers/pinctrl/mediatek/pinctrl-mt8135.c   | 2 +-
>  drivers/pinctrl/mediatek/pinctrl-mt8173.c   | 2 +-
>  

For the pinctrl-mt81xx driver,
Acked-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

By the way, Axel has sent same patch to linux-gpio.
http://article.gmane.org/gmane.linux.kernel.gpio/6815

Thanks.
Hongzhou
