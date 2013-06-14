From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 14 Jun 2013 09:29:58 +0530
Subject: [PATCH 6/7] ARM: spear: remove #gpio-ranges-cells property
In-Reply-To: <1371157199-7272-6-git-send-email-swarren@wwwdotorg.org>
References: <1371157199-7272-1-git-send-email-swarren@wwwdotorg.org>
 <1371157199-7272-6-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAOh2x==PmNwbYwAgFPW5M0UyB=AeE1sbpTfOsR0utQOHUTYPwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 2:29 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> This property is no longer required by the GPIO binding. Remove it.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This should presumably be applied along with the previous changes
> ---
>  arch/arm/boot/dts/spear1310.dtsi | 1 -
>  arch/arm/boot/dts/spear1340.dtsi | 1 -
>  arch/arm/boot/dts/spear310.dtsi  | 1 -
>  arch/arm/boot/dts/spear320.dtsi  | 2 --
>  4 files changed, 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
