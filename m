From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 13 Sep 2017 12:15:33 -0700
Subject: [PATCH] clk: spear: make clk_ops const
In-Reply-To: <1503407690-13541-1-git-send-email-bhumirks@gmail.com>
References: <1503407690-13541-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170913191533.GA11836@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-08-17, 18:44, Bhumika Goyal wrote:
> Make these const as they are only stored in the const field of a
> clk_init_data structure.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/clk/spear/clk-aux-synth.c  | 2 +-
>  drivers/clk/spear/clk-frac-synth.c | 2 +-
>  drivers/clk/spear/clk-gpt-synth.c  | 2 +-
>  drivers/clk/spear/clk-vco-pll.c    | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
