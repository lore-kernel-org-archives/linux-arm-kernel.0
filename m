From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 18 Apr 2012 14:04:43 -0700
Subject: [PATCH 02/13] clk: Fix typo in comment
In-Reply-To: <3ebf7ae767a0af87a27bb40592e33ff97152edf5.1334660431.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <3ebf7ae767a0af87a27bb40592e33ff97152edf5.1334660431.git.viresh.kumar@st.com>
Message-ID: <CAJOA=zMXxh432Ogmex2hDp+C83_98WqZ1WniVeW2jEtPJCRYdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 4:15 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> CLK_GATE_SET_TO_DISABLE is mistakenly written as CLK_GATE_SET_DISABLE in
> comment. Fix it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Thanks for the fix.  I'll combine this patch with your
CLK_MUX_INDEX_BIT typo fix and pull into my -next branch.

Regards,
Mike

> ---
> ?include/linux/clk-provider.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 50ee80b..d98bdbc 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -166,7 +166,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
> ?* Clock which can gate its output. ?Implements .enable & .disable
> ?*
> ?* Flags:
> - * CLK_GATE_SET_DISABLE - by default this clock sets the bit at bit_idx to
> + * CLK_GATE_SET_TO_DISABLE - by default this clock sets the bit at bit_idx to
> ?* ? ? enable the clock. ?Setting this flag does the opposite: setting the bit
> ?* ? ? disable the clock and clearing it enables the clock
> ?*/
> --
> 1.7.9
>
