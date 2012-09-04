From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 05 Sep 2012 06:39:56 +0900
Subject: [PATCH] gpio: samsung: Update documentation
In-Reply-To: <5045B89D.50503@samsung.com>
References: <503D267A.2090406@gmail.com>
 <1346603089-14122-1-git-send-email-sylvester.nawrocki@gmail.com>
 <CACRpkdbudOv9AvS1XuyPB+BZ63+Ymu5dhkBBWFCo2qYDV+jAmw@mail.gmail.com>
 <5045B89D.50503@samsung.com>
Message-ID: <226401cd8ae5$d3e0ee90$7ba2cbb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> On 09/04/2012 09:27 AM, Linus Walleij wrote:
> > On Sun, Sep 2, 2012 at 6:24 PM, Sylwester Nawrocki
> > <sylvester.nawrocki@gmail.com> wrote:
> >
> >> Update Samsung GPIO API documentation to reflect removal of
> >> the s3c24xx specific gpio API. While at it, fix some typos.
> >>
> >> The notes on conversion from s3c2410_* functions to the gpiolib
> >> API are left here just in case there is any out of tree code that
> >> still needs to be converted.
> >>
> >> Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> >
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Get the Samsung maintainers to apply this patch since they carry
> > the API changes.
> 
Linus, thanks for your ack.

> Thanks Linus. Kgene, this is the documentation update we talked about
> previously. Can you please pick this patch as well ?
> 
Sure, I will apply this into Samsung tree.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
