From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Sep 2012 10:24:42 -0600
Subject: [PATCH v2] pinctrl: clarify idle vs sleep states
In-Reply-To: <1348816688-27531-1-git-send-email-linus.walleij@stericsson.com>
References: <1348816688-27531-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5065CF4A.9070406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 01:18 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This pure documentation fix tries to align the "idle" and
> "sleep" pin states to the idle and suspend states from
> runtime PM.
> 
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - I changed my mind slightly after experimentation in practice
>   (empirical stuff is the best). So now I think "idle" is for
>   runtime_suspend(), and "sleep" is for suspend() proper. This
>   works best in practice for us. I'm trying to set some model
>   here that will be easy to understand and usable for typical
>   cases.

Yes, I think this makes sense.

Acked-by: Stephen Warren <swarren@nvidia.com>
