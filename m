From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 26 Nov 2012 11:32:49 +0000
Subject: [alsa-devel] [PATCH 0/3] ASoC: Davinci: McASP: add support new
 McASP IP Variant
In-Reply-To: <CAGm1_kut_wmno7vG_Vm=7c7e4A7ih+PpGP-GzzYWrfT99UC0FQ@mail.gmail.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <506B6A9D.3090100@gmail.com>
 <1BAFE6F6C881BF42822005164F1491C33EA99A40@DBDE01.ent.ti.com>
 <506C1E97.1070700@gmail.com>
 <1BAFE6F6C881BF42822005164F1491C33EA99DA8@DBDE01.ent.ti.com>
 <CAGm1_kut_wmno7vG_Vm=7c7e4A7ih+PpGP-GzzYWrfT99UC0FQ@mail.gmail.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EAD7872@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yegor,

On Sun, Nov 25, 2012 at 15:56:27, Yegor Yefremov wrote:
> On Wed, Oct 3, 2012 at 2:57 PM, Hebbar, Gururaja <gururaja.hebbar@ti.com> wrote:
> > On Wed, Oct 03, 2012 at 16:46:39, Daniel Mack wrote:
> >> On 03.10.2012 09:16, Hebbar, Gururaja wrote:
> >> > On Wed, Oct 03, 2012 at 03:58:45, Daniel Mack wrote:
> >> >> On 31.08.2012 14:50, Hebbar, Gururaja wrote:
> >> >>> The OMAP2+ variant of McASP is different from Davinci variant w.r.to some
> >> >>> register offset and missing generic SRAM APIs support
> >> >>>

..snip..
..snip..

> >>
> >> Please do :) Or just push your entire tree somewhere.
> >
> > I have pushed the code at below git repo
> > Repo :https://github.com/hvaibhav/am335x-linux
> > Branch : am335x-upstream-staging-audio
> >
> > This includes
> > 1. (linux-next + AM335x patches)
> > 2. McASP DT conversion
> > 3. EDMA hack
> > 4. AM335x audio specific DT blobs
> > 5. Am335x dma DT blobs [hack]
> >
> > Kindly let me know if you need any more details.
> 

> What can be expected in 3.8? 

1. ASoC McASP DT conversion is 80% complete. Davinci Machine DT conversion
& McASP pinctrl support is yet to be accepted. I sent a patch recently and 
waiting for feedback.

> And what will have to wait for 3.9?
AFAIK
1. EDMA port for McASP driver
2. AM335x support on Davinci ASoC (Kconfig & makefile)
3. DT blobs for Audio modules on AM335x (am335x-evm.dts & am33xx.dtsi)

> 
> Yegor
> 


Regards, 
Gururaja
