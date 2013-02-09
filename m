From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 09 Feb 2013 09:25:25 +0000
Subject: [PATCH 3/9] gpiolib: use gpio_chips list in gpiochip_find
In-Reply-To: <CACRpkdaVwjv2DwSx667sgVkHqx-tHsy6A0mP-kvq6h9nDDBrGA@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-5-git-send-email-acourbot@nvidia.com>
 <CACRpkdaVwjv2DwSx667sgVkHqx-tHsy6A0mP-kvq6h9nDDBrGA@mail.gmail.com>
Message-ID: <20130209092525.9F9A23E2C48@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Feb 2013 18:05:32 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > Using the GPIO chips list is much faster than parsing the entire GPIO
> > number space.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> You don't say :-)
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

g.
