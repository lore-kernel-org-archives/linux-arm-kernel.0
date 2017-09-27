From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 27 Sep 2017 10:42:51 -0700
Subject: [PATCH] clk/spear: Delete five error messages for a failed
 memory allocation
In-Reply-To: <4283fdab-7005-f774-9594-821582c5a9fb@users.sourceforge.net>
References: <4283fdab-7005-f774-9594-821582c5a9fb@users.sourceforge.net>
Message-ID: <20170927174251.GD12211@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-09-17, 18:15, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Sep 2017 18:00:21 +0200
> 
> Omit extra messages for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/clk/spear/clk-aux-synth.c  | 4 +---
>  drivers/clk/spear/clk-frac-synth.c | 4 +---
>  drivers/clk/spear/clk-gpt-synth.c  | 4 +---
>  drivers/clk/spear/clk-vco-pll.c    | 8 ++------
>  4 files changed, 5 insertions(+), 15 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
