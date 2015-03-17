From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 17 Mar 2015 11:54:26 +0100
Subject: [PATCH v2] clk: samsung: Add CLKOUT driver support for Exynos3250
 SoC.
In-Reply-To: <5500D11A.6010200@codeaurora.org>
References: <1425262500-27456-1-git-send-email-ideal.song@samsung.com>
 <5500D11A.6010200@codeaurora.org>
Message-ID: <550807E2.8060205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/15 00:34, Stephen Boyd wrote:
> On 03/01/15 18:15, Inha Song wrote:
>> > This patch add CLKOUT driver support for Exynos3250 SoC.
>> >
>> > Exynos3250 SoC PMU_DEBUG is the same with Exynos4's PMU_DEBUG
>> > including CLKOUT mux. So, We can use the exynos4's clkout init
>> > function for Exynos3250 without the need to add new function.
>> >
>> > Signed-off-by: Inha Song <ideal.song@samsung.com>
>
> Do you want to take this through some SoC tree? If so:
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks, I added this patch to my tree.
