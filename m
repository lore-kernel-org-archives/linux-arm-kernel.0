From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 27 Jan 2015 17:10:45 -0800
Subject: [PATCH 1/2] clk: pxa: add pxa3xx clock driver
In-Reply-To: <87wq49p2ey.fsf@free.fr>
References: <1420577139-30556-1-git-send-email-robert.jarzmik@free.fr>
 <87wq49p2ey.fsf@free.fr>
Message-ID: <20150128011045.22722.19778@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Robert Jarzmik (2015-01-26 15:06:45)
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > Move pxa25x clock drivers from arch/arm/mach-pxa to driver/clk.
> > In the move :
> >  - convert to new clock framework legacy clocks
> >  - provide clocks as before for platform data based boards
> >  - provide clocks through devicetree with clk-pxa-dt
> >
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> Hi Mike,
> 
> Would there be a change for this to land in 3.20 (only patch 1/2) ?
> 
> Of course it won't be activated, as my intention is to use 3.21 as my vehicle to
> swap pxa25x, pxa27x and pxa3xx to common clock framework though pxa tree.
> 
> FWIW, this was tested on the zylonite board so far.

Applied patch #1 to clk-next for 3.20.

Regards,
Mike

> 
> Cheers.
> 
> --
> Robert
