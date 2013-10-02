From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 02 Oct 2013 23:10:52 +0200
Subject: [PATCH 2/5] gpio: samsung: Use CONFIG_ARCH_S3C64XX to check for
 S3C64xx support
In-Reply-To: <CACRpkdZXOGpTspPucd=d0=Ws9Ccx19h4UYTTdgZceoofhuq0Kw@mail.gmail.com>
References: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
 <1380392497-27406-2-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdZXOGpTspPucd=d0=Ws9Ccx19h4UYTTdgZceoofhuq0Kw@mail.gmail.com>
Message-ID: <3903161.Vxg4RcbQZc@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wednesday 02 of October 2013 12:46:51 Linus Walleij wrote:
> On Sat, Sep 28, 2013 at 8:21 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > Since CONFIG_PLAT_S3C64XX is going to be removed, this patch modifies
> > the gpio-samsung driver to use the proper way of checking for S3C64xx
> > support - CONFIG_ARCH_S3C64XX.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.

> I assume that this will go through ARM SoC?

I think so.

Best regards,
Tomasz
