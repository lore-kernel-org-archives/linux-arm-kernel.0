From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 8 Jan 2014 10:14:47 +0530
Subject: [PATCH] clk: Correct handling of NULL clk in __clk_{get, put}
In-Reply-To: <1389096223-23934-1-git-send-email-s.nawrocki@samsung.com>
References: <1389096223-23934-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <CAK9yfHx+=X+DiLe_WsiDkYonKCssPTOGqR76=+7N6eyAHXyQGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 7 January 2014 17:33, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> Ensure clk->kref is dereferenced only when clk is not NULL.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Hi Sachin,
>
> please try if this patch fixes the exyno5420 boot crash.

Confirmed that this patch works fine on 5420 as well as already
working 4210 and 5250 boards.
Thanks for the quick fix.

Tested-by: Sachin Kamat <sachin.kamat@linaro.org>


-- 
With warm regards,
Sachin
