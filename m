From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Wed, 13 Mar 2013 22:39:18 +0530
Subject: [PATCH 1/1] clk: Fix incorrect return type in clk.c
In-Reply-To: <1363168069-11331-1-git-send-email-sachin.kamat@linaro.org>
References: <1363168069-11331-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CADTbHxrF5M++Y5ku90uN7n6Jx=o80qY+dFX+B_s0udSC06D-PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Wed, Mar 13, 2013 at 3:17 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Return type of function clk_propagate_rate_change is a pointer.
> But 0 was being returned. Change it to NULL.
> Silences the following warning:
> drivers/clk/clk.c:977:24: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/clk/clk.c |    2 +-

Looks good to me.
Reviewed-by: Pankaj Jangra <jangra.pankaj9@gmail.com>

Regards,
Pankaj Jangra
