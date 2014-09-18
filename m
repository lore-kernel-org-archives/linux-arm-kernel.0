From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 18 Sep 2014 10:18:12 -0700
Subject: [PATCH v5 2/4] dt-bindings: document Rockchip thermal
In-Reply-To: <CAAObsKCYGEBNEvDTs=iQD9KT0YomQWHg0W-vwHG4nLZbqogF=g@mail.gmail.com>
References: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com>
 <1410926353-15674-3-git-send-email-caesar.wang@rock-chips.com>
 <CAAObsKA61Ano85P6PehOY7WqR0FgTz_Rfur8UAt56ZXoNyoyqQ@mail.gmail.com>
 <541ADD58.7070901@rock-chips.com>
 <CAAObsKCYGEBNEvDTs=iQD9KT0YomQWHg0W-vwHG4nLZbqogF=g@mail.gmail.com>
Message-ID: <20140918171809.GD14809@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 04:19:26PM +0200, Tomeu Vizoso wrote:
> On 18 September 2014 15:25, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> > Tomeu,
> >
> > ? 2014?09?18? 17:27, Tomeu Vizoso ??:
> >>
> >> On 17 September 2014 05:59, Caesar Wang <caesar.wang@rock-chips.com>
> >> wrote:
> >>>
> >>> This add the necessary binding documentation for the thermal
> >>> found on Rockchip SoCs
> >>
> >> Hi Caesar,
> >>
> >> is there any reason to not use the existing thermal bindings? You can
> >> find a description in
> >> Documentation/devicetree/bindings/thermal/thermal.txt and example code
> >> in omap, or in the patches for Tegra recently posted by Mikko
> >> Perttunen.
> >>
> >> Regards,
> >>
> >> Tomeu
> >
> >
> > Why should I use the existing thermal bindings?
> 
> Because otherwise, you are asking to merge duplicated code. There's a
> generic way to define thermal zones, trip points, cooling devices,
> etc. And also code to parse and plug them together. Why add
> soc-specific code to do the same?
> 
> > I believe omap,tegar and rockchip are  the three seperate thermals driver.
> 
> Yes, and OMAP is already using the generic bindings, and the proposed
> patches for Tegra as well, and I think it would make sense for
> Rockchip to also use them (unless I'm missing something).

You are talking about drivers/thermal/of-thermal.c, right? Yes, I think
Rockchip should be using the same generic framework if possible.

Thanks.

-- 
Dmitry
