From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 11 Apr 2012 12:17:47 +0530
Subject: [PATCH] clk: clk_calc_new_rates() required for parent only if
 CLK_SET_RATE_PARENT is set
In-Reply-To: <20120411064359.GD20478@pengutronix.de>
References: <0b5e799807b09e47db1bf2805359aae36d947f60.1334124495.git.viresh.kumar@st.com>
 <20120411064359.GD20478@pengutronix.de>
Message-ID: <4F852913.20708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/11/2012 12:13 PM, Sascha Hauer wrote:
> I see no functional change in this patch. With or without this patch we
> only call clk_calc_new_rates() when the parent rate actually changed.
> The code is easier to read with this patch and may be slightly more
> efficient, so:
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks Sascha. :)
Actually i am doing SPEAr clock stuff and i have to look at already
implemented clock source files. when i feel something can be rearranged
in a better way (atleast according to me :) ), i patch it.

They wouldn't be tested as i don't have SPEAr stuff ready. Will mention this
untested thing in patch next time.

You may see some more of these in coming time.

-- 
viresh
