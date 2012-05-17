From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 17 May 2012 21:09:21 +0530
Subject: [PATCH 3/7] mmc: dw_mmc: add device tree support
In-Reply-To: <Pine.LNX.4.64.1205122117340.11826@axis700.grange>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
 <Pine.LNX.4.64.1205040047280.18111@axis700.grange>
 <CAJuYYwQj7gzZ9piJAJLcf7SiyJnQ6nZ63-X9ieQ-FCj6TNhQPQ@mail.gmail.com>
 <Pine.LNX.4.64.1205122117340.11826@axis700.grange>
Message-ID: <CAJuYYwTf=+Nkw2Ox9MYLybovSH8dNttYQzV4-Gg2xvZnVffZXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 May 2012 01:01, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Sure. I think, my patch, that I mentioned above, shall be dropped, at
> least in its present form. But if at least in principle we do want to have
> a common MMC OF parser for common bindings, some code from your patch
> would become redundant, I think. BTW, isn't this
>
> + ? ? ? gpio = of_get_named_gpio(np, "wp_gpios", 0);
>
> a typo? Shouldn't it be "wp-gpios" instead?

Yes, it is a typo. Thanks for your review. This is fixed now.

Regards,
Thomas.
