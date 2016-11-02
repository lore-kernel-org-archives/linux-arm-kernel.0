From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 2 Nov 2016 07:55:53 +0530
Subject: [PATCH] ARM: spear: Fix error handling
In-Reply-To: <20161029135839.6388-1-christophe.jaillet@wanadoo.fr>
References: <20161029135839.6388-1-christophe.jaillet@wanadoo.fr>
Message-ID: <CAOh2x=kiECTSiSk0+R63gDbm8_NM6wDm=03RJKEyznnHfOZuDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 7:28 PM, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> 'clk_get_sys()' returns an error pointer in case of error, not NULL. So
> test it with IS_ERR.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/arm/mach-spear/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
