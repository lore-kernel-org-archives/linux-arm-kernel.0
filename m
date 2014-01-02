From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 02 Jan 2014 16:22:12 +0100
Subject: [PATCH v2 0/8] clk: max77686: Clock provider implementation fixes
In-Reply-To: <20131231194215.12054.39705@quantum>
References: <1386864441-19561-1-git-send-email-t.figa@samsung.com>
 <20131231194215.12054.39705@quantum>
Message-ID: <2890647.PEOApIOYyP@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 of December 2013 11:42:15 Mike Turquette wrote:
> Quoting Tomasz Figa (2013-12-12 08:07:13)
> > This series intends to improve clock provider impementation of max77686
> > PMIC driver. First two patches are simple fixes of current implementation
> > to allow correct control of provided clocks. Further patches refactor
> > the driver to make the code cleaner and prepare for further patches. Then
> > last two patches add registration of OF clock provider and adjust device
> > tree nodes of boards containing max77686 chip to contain properties
> > required by clock provider.
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>

Hmm... Shouldn't this series go through the clk tree directly? If not, who
should be taking it?

Best regards,
Tomasz
