From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 20 Aug 2013 12:19:39 +0530
Subject: [PATCH] pinctrl: SPEAr310: Pass correct of_device_id table name
 to MODULE_DEVICE_TABLE
In-Reply-To: <1376978280.19775.1.camel@phoenix>
References: <1376978280.19775.1.camel@phoenix>
Message-ID: <CAOh2x=nvnvuXf3C8Mgk1_5fxYR-eSqPek8M=DwPM-ombnSKLPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 11:28 AM, Axel Lin <axel.lin@ingics.com> wrote:
> The symbol SPEAr310_pinctrl_of_match does not exist at all. Fix it.
> We didn't hit the compile error because this driver can only be built-in now.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pinctrl/spear/pinctrl-spear310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
