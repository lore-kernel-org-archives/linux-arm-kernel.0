From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 03 Apr 2013 17:49:10 -0700
Subject: [PATCH 4/6] pinctrl: sunxi: add clock support
In-Reply-To: <515C9D25.3050407@free-electrons.com>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1363962042-29536-5-git-send-email-emilio@elopez.com.ar>
 <CACRpkdbn9c_bAWUN8hTLkeidCnyZ=0nRQRBV39DMkK_0jBfoUQ@mail.gmail.com>
 <51535077.1050203@free-electrons.com>
 <CACRpkda80EKT2LbsBCOng=gkdtdd+vbYwkMPiFZUBx7z_aqY+A@mail.gmail.com>
 <515C9D25.3050407@free-electrons.com>
Message-ID: <20130404004910.3383.10381@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2013-04-03 14:20:37)
> Hi Linus,
> 
> Le 03/04/2013 13:59, Linus Walleij a ?crit :
> > On Wed, Mar 27, 2013 at 9:03 PM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > 
> >> Hi Linus,
> >> Le 27/03/2013 14:14, Linus Walleij a ?crit :
> >>> On Fri, Mar 22, 2013 at 3:20 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> >>>
> >>>> For the port controller to work, we need to enable the apb0_pio gate.
> >>>> This commit adds the ability to enable one clock specified on the device
> >>>> tree to the pinctrl driver.
> >>>>
> >>>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> >>>
> >>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>>
> >>> I guess you'll want to merge these as one series to some platform-specific
> >>> tree, tell me if you want it merged in the pinctrl tree.
> >>
> >> The easiest would probably be to merge this patch through your patch,
> >> with Mike taking the clock driver patches and me taking the dt ones,
> >> once we agree on the other patches.
> > 
> > OK then, patch applied to the pinctrl tree, thanks!
> 
> Ouch, the previous patches aren't applied yet by Mike, and we didn't
> have some comments from him about these patches, so I can't really say
> if the previous patches will get merge by 3.10 or not... So we will
> maybe end up with a broken pinctrl stuff.
> 
> Mike, do you have some comments on Emilio's patches?
> 
> If you do, we can still fix things up later by applying a slightly
> modified version of patches 5/6 with a clock that is already there, for
> it to load properly.
> 

Hi Maxime,

I did leave some comments a few hours ago.  It would be better if the
fixes could be rolled in now, but if that is somehow impossible then I
don't mind taking them as-is with fixes at a later date.  Just let me
know.

Regards,
Mike

> Thanks,
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
