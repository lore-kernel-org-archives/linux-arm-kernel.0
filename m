From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 19:40:49 +0800
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <20120530100302.GD9947@opensource.wolfsonmicro.com>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdbQv8Q07iRAmG3UQRm7UNDi_Y+s_vvACDKKxR9tg+1iqg@mail.gmail.com>
 <20120530100302.GD9947@opensource.wolfsonmicro.com>
Message-ID: <CAF2Aj3gZMF9ev9B46rBM+aY-srwthef09ad2CWfuXXFHmqqAjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 30, 2012 6:03 PM, "Mark Brown" <broonie@opensource.wolfsonmicro.com>
wrote:
>
> On Wed, May 30, 2012 at 02:58:44PM +0800, Linus Walleij wrote:
> > On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org>
wrote:
>
> > > +       { .name = "ab8500_ldo_ana",     .driver_data = (void *)
AB8500_LDO_ANA, },
>
> > So why is the device tree going to use these lowercase names etc?
> > I guess there is a rationale...
>
> If we are changing the names then not including the ab8500 bit would
> seem more idiomatic - we've already worked out which chip this is by the
> time we're looking here.
>
> > Anyway: the name is used in more parts of the file, so please change
> > it everywhere if you change it.
>
> It's only used for a few debug prints AFAICT?

No, Linus had the wrong end of the stick. I've just spoken to him in person.

Those are not the names of the regulators. They're the names of the Device
Tree nodes. The regulator names shall remain the same.

Sent from my Linux based mobile device.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120530/4aa7acc2/attachment-0001.html>
