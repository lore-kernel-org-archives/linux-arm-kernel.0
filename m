From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 30 May 2013 11:13:43 +0200
Subject: [PATCH v6 01/10] ASoC: phycore-ac97: Add DT support
In-Reply-To: <CAOZdJXVL2uP-qW=kydgS-t3C=C+6Cn9D3FWqbMuoK2c-EnckyA@mail.gmail.com>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
 <1369752478-30260-2-git-send-email-mpa@pengutronix.de>
 <20130529135342.GB29528@S2101-09.ap.freescale.net>
 <CAOZdJXVL2uP-qW=kydgS-t3C=C+6Cn9D3FWqbMuoK2c-EnckyA@mail.gmail.com>
Message-ID: <20130530091343.GB31548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 10:41:58AM -0500, Timur Tabi wrote:
> On Wed, May 29, 2013 at 8:53 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> >
> > This function is unavailable until patch #7, right?
> 
> 
> May I suggest that Markus run this script:
> 
> for i in 1 2 3 4 5 6 7 8 9
> do
>   git checkout HEAD^
>   make
> done
> 
> It's important that each commit in a patchset be compilable, otherwise
> git-bisect will break.
> 

I will reorder the patches in the series so that the kernel is
compilable after each patch.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
