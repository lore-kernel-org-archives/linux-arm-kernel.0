From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 May 2012 19:59:20 +0800
Subject: [PATCH V2 06/11] ASoC: fsl_ssi: convert to use devm_clk_get
In-Reply-To: <20120509115041.GM3955@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-7-git-send-email-richard.zhao@freescale.com>
 <20120509115041.GM3955@opensource.wolfsonmicro.com>
Message-ID: <CAAQ0ZWSiRysfkUnu2ZoDXFtiJz-nfrQ-DTKOgCpKpCe5LpQj3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 May 2012 19:50, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 09, 2012 at 07:33:05PM +0800, Richard Zhao wrote:
>> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>
> I'll apply this when devm_clk_get() makes it into mainline (hopefully in
> the merge window); please remind me if I forget.

We will have rmk's clkdev branch appear on arm-soc as dependency
anyway.  Can we have this series go over arm-soc tree, since we will
have all the dependencies on clk and pinctrl meet and conflicts solved
there?

Regards,
Shawn
