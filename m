From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 30 May 2014 06:46:07 +0530
Subject: [PATCH 2/2] ARM: spear: Staticize local symbols in spear1340.c
In-Reply-To: <1401269280-3567-2-git-send-email-sachin.kamat@linaro.org>
References: <1401269280-3567-1-git-send-email-sachin.kamat@linaro.org>
 <1401269280-3567-2-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAKohponMgwOnOV8wQw3O3pUGHtkuKgn-F=OmB-EfQBzbOvXgSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 May 2014 14:58, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Symbols local to this file are made static.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  arch/arm/mach-spear/spear1340.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
