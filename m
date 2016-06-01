From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 01 Jun 2016 11:59:02 +0200
Subject: [PATCH 2/6] clk: samsung: exynos5410: Add TMU clock
In-Reply-To: <8281b473-22c8-f87d-4282-45f93f61b937@osg.samsung.com>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
 <1464719945-3417-2-git-send-email-krzk@kernel.org>
 <8281b473-22c8-f87d-4282-45f93f61b937@osg.samsung.com>
Message-ID: <574EB1E6.8050808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2016 08:56 PM, Javier Martinez Canillas wrote:
> On 05/31/2016 02:39 PM, Krzysztof Kozlowski wrote:
>> > Add clock for TMU to the Exynos5410 clock driver.
>> > 
>> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> > ---
>> >  drivers/clk/samsung/clk-exynos5410.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
>> > index 6c2e59c576ee..db9978dc6e83 100644
>> > --- a/drivers/clk/samsung/clk-exynos5410.c
>> > +++ b/drivers/clk/samsung/clk-exynos5410.c
>> > @@ -160,6 +160,7 @@ static struct samsung_div_clock exynos5410_div_clks[] __initdata = {
>> >  static struct samsung_gate_clock exynos5410_gate_clks[] __initdata = {
>> >  	GATE(CLK_MCT, "mct", "aclk66", GATE_IP_PERIS, 18, 0, 0),
>> >  	GATE(CLK_RTC, "rtc", "aclk66", GATE_IP_PERIS, 20, 0, 0),
>> > +	GATE(CLK_TMU, "tmu", "aclk66", GATE_IP_PERIS, 21, 0, 0),
>> >  
>> >  	GATE(CLK_SCLK_MMC0, "sclk_mmc0", "div_mmc_pre0",
>> >  			SRC_MASK_FSYS, 0, CLK_SET_RATE_PARENT, 0),
>> > 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

I have applied patches 1/6, 2/6. I will hold back for a moment
with providing another tag for the "dt-bindings" patches, in case
there are more such patches submitted in the coming days.

-- 
Thanks,
Sylwester
