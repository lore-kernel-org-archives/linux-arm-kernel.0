From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 2 Feb 2016 19:13:52 +0100
Subject: [PATCH v3 1/2] clk: sunxi: Add sun6i/8i video support
In-Reply-To: <CACvgo53f8Sr_dEAx_mcvjXciK01mY7TUDguOJ-HzNur-PpmMZw@mail.gmail.com>
References: <cover.1454427223.git.moinejf@free.fr>
 <8fdfe5fe7715f19416d654964e55721b30237b38.1454427224.git.moinejf@free.fr>
 <CACvgo53f8Sr_dEAx_mcvjXciK01mY7TUDguOJ-HzNur-PpmMZw@mail.gmail.com>
Message-ID: <20160202191352.2b21ae1c5de288e008841b1f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Feb 2016 17:19:15 +0000
Emil Velikov <emil.l.velikov@gmail.com> wrote:

> > ---
> >  Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
> >  drivers/clk/sunxi/clk-sun6i-display.c             | 106 +++++++++++++
> >  drivers/clk/sunxi/clk-sun6i-pll3.c                | 174 ++++++++++++++++++++++
> >  3 files changed, 282 insertions(+)
> >  create mode 100644 drivers/clk/sunxi/clk-sun6i-display.c
> >  create mode 100644 drivers/clk/sunxi/clk-sun6i-pll3.c
> >
> Something is missing here - namely the changes to the Makefile. Does
> this series work or did you simply forget git add ?

Yes, the series works. I just forgot the Makefile which contains other
changes for my kernel (thermal clock).

Thanks. I sent an new request.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
