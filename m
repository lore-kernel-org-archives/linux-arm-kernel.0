From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 22 Sep 2012 17:34:32 +0800
Subject: [alsa-devel] [PATCH v2 00/34] i.MX multi-platform support
In-Reply-To: <CAOesGMg+FvoVmiCee5hhe+_ZtBpvsnsi2N3vvLmZz1Tq3pOBWw@mail.gmail.com>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
 <20120920145342.GI2450@S2101-09.ap.freescale.net>
 <201209201556.57171.arnd@arndb.de>
 <20120921080123.GM2450@S2101-09.ap.freescale.net>
 <CAOesGMi6CbvFikycJVdE8W-DxLD3W7+CyScz+YT103dxR31U9g@mail.gmail.com>
 <20120921164622.GA5394@S2101-09.ap.freescale.net>
 <20120921165305.GB5394@S2101-09.ap.freescale.net>
 <CAOesGMiHJnt7zq19ZycxaNUD64QzLYw7o79pP-Y91-zi60ny6g@mail.gmail.com>
 <CAOesGMg+FvoVmiCee5hhe+_ZtBpvsnsi2N3vvLmZz1Tq3pOBWw@mail.gmail.com>
Message-ID: <20120922093430.GC5394@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 01:09:27AM -0700, Olof Johansson wrote:
> > I've pulled this in now as staging/imx-multiplatform.
> >
> > As you mention, it might or might not make sense to send this up. It
> > also accrued a few more merge conflicts with other branches in
> > arm-soc, so we'll see how things play out.
> >
> > Either way, we'll for sure queue it for 3.8.
> 
> Hmm. Pulling it in gives me a few new build errors, in particular on
> the configs that Russell use to build test omap3, as well as one of
> his vexpress configs. So I dropped it again for now.
> 
> Let's have the current contents sit in linux-next for at least one
> release before we bring in anything more, especially since it brings
> in dependencies on external trees, and it also has a handful of new
> merge conflicts. We're already exposing Stephen Rothwell to more merge
> conflicts than I'm entirely comfortable with.
> 
Ok.  I will rebase the series against 3.7-rc1 and then send you then.

Shawn
