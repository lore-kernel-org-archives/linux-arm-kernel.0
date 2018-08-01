From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 01 Aug 2018 15:10:29 +0200
Subject: [PATCH] drm/rockchip: Convert drm_atomic_helper_suspend/resume()
In-Reply-To: <CAFqt6zZfLXuMUT75a3dWKeiCCmKZOfi=FdTeFRjcdFDZdfcRVQ@mail.gmail.com>
References: <20180731203430.GA30136@jordon-HP-15-Notebook-PC>
 <16141309.kTfAWOe8rM@phil>
 <CAFqt6zZfLXuMUT75a3dWKeiCCmKZOfi=FdTeFRjcdFDZdfcRVQ@mail.gmail.com>
Message-ID: <1843623.lUM99VBV1x@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 1. August 2018, 14:43:47 CEST schrieb Souptick Joarder:
> On Wed, Aug 1, 2018 at 6:03 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > Hi Souptick,
> >
> > Am Dienstag, 31. Juli 2018, 22:34:30 CEST schrieb Souptick Joarder:
> >> convert drm_atomic_helper_suspend/resume() to use
> >> drm_mode_config_helper_suspend/resume().
> >>
> >> With this conversion, rockchip_drm_fb_resume() and
> >> rockchip_drm_fb_suspend() will not be used anymore.
> >> Both of these functions can be removed.
> >>
> >> Also, in struct rockchip_drm_private state will not be
> >> used anymore. So this can be removed forever.
> >>
> >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> >
> > the patch itself looks great, just a simple bookkeeping question.
> >
> > What role did Ajit play in creating the patch? If I remember correctly
> > it is meant to be
> > - 1st Signed-off: Patch-Author
> > - 2nd Signed-off: E-Mail sender + patch possibly patch changes
> > (optional of course if the same)
> >
> > So was this meant to be a Reviewed-by from Ajit?
> 
> We both are working together for these patches to
> convert drm_atomic_helper_suspend/resume().
> That's the reason to add his name in 2nd Signed-off
> in all similar patches.
> 
> Is it a incorrect way to put 2nd Signed-off here ?

Thanks for the clarification and the interesting question :-)

I've just read through Documentation/process/submitting-patches.rst
and it seems there is an "official" way to show that relationship, via a
tag named "Co-Developed-by:" described under number 12.

So I guess we could just adapt the patch accordingly, if that is ok with
both of you (i.e. I can change this when applying, so no need to resend).


Heiko
