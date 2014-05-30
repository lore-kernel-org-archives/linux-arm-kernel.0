From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 30 May 2014 06:45:45 +0530
Subject: [PATCH 1/2] ARM: spear: Staticize spear1310_io_desc in spear1310.c
In-Reply-To: <1401269280-3567-1-git-send-email-sachin.kamat@linaro.org>
References: <1401269280-3567-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAKohpomyCYeHxA0BEbK0dnTJ65SrE2=rUuCUW5yPMA1EmRmfxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 May 2014 14:57, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> 'spear1310_io_desc' is used only in this file.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  arch/arm/mach-spear/spear1310.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
