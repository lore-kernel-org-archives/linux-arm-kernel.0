From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 2 May 2018 09:48:25 +0200
Subject: [PATCH] ARM: dts: at91: sama5d4ek: use canonical compatible for
 touchscreen
In-Reply-To: <20180501224833.GA151132@dtor-ws>
References: <20180501224833.GA151132@dtor-ws>
Message-ID: <20180502074825.GB18640@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2018 15:48:33-0700, Dmitry Torokhov wrote:
> The canonical compatible string is "atmel,maxtouch", let's use it. Also,
> change the node name to be "touchscreen" rather than driver name.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/arm/boot/dts/at91-sama5d4ek.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
