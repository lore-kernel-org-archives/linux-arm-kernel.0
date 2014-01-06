From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Jan 2014 11:06:04 +0000
Subject: [PATCH v2 0/8] clk: max77686: Clock provider implementation fixes
In-Reply-To: <2890647.PEOApIOYyP@amdc1227>
References: <1386864441-19561-1-git-send-email-t.figa@samsung.com>
 <20131231194215.12054.39705@quantum> <2890647.PEOApIOYyP@amdc1227>
Message-ID: <20140106110604.GN23772@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > This series intends to improve clock provider impementation of max77686
> > > PMIC driver. First two patches are simple fixes of current implementation
> > > to allow correct control of provided clocks. Further patches refactor
> > > the driver to make the code cleaner and prepare for further patches. Then
> > > last two patches add registration of OF clock provider and adjust device
> > > tree nodes of boards containing max77686 chip to contain properties
> > > required by clock provider.
> > 
> > Acked-by: Mike Turquette <mturquette@linaro.org>
> 
> Hmm... Shouldn't this series go through the clk tree directly? If not, who
> should be taking it?

I'm not quite sure why this patch-set was sent to me in the first
place, but I guess that's by the by.

Mike is probably waiting for the ARM and DT patches to be Acked,
applied.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
