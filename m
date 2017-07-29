From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 30 Jul 2017 00:47:36 +0200
Subject: [PATCH] ARM: at91: dts: add AC97 support for AT91SAM9G45
In-Reply-To: <20170618124049.6663-1-dmitry.rezvanov@yandex.ru>
References: <20170612194314.19289-1-dmitry.rezvanov@yandex.ru>
 <20170618124049.6663-1-dmitry.rezvanov@yandex.ru>
Message-ID: <20170729224736.oqdre7hunsritxia@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/06/2017 at 21:40:49 +0900, Dmitry Rezvanov wrote:
> Hi, Thanks for the comments, I'm still a newbie and this is my first patch.
> I have made corrections in accordance with your recommendations.
> 
> P.S. Regarding compatible string - since there are no other changes in
> the driver, I changed it to "atmel, at91sam9263-ac97c".
> But in my opinion, it's a bit ... weird.

Well, that is how it is done. Have a look at all hte rm9200 compatibles
in at91sam9g45.dtsi

> ---
> 
> AT91SAM9G45 has an AC97 controller, but it is not described in the dts file.
> This patch adds AC97 node in device tree.
> 
> Signed-off-by: Dmitry Rezvanov <dmitry.rezvanov@yandex.ru>
> ---
>  arch/arm/boot/dts/at91sam9g45.dtsi     | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9m10g45ek.dts |  4 ++++
>  2 files changed, 25 insertions(+)
> 

Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
