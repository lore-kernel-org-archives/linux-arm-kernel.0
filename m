From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 7 Jan 2012 11:45:00 +0100
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
In-Reply-To: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20120107104500.GA2854@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:48 Fri 06 Jan     , Daniel Lezcano wrote:
> Move the location of the pm.h header file to the include directory,
> so it can be included from another place from the current one.
> 
> That will allow the next patch which moves the cpuidle code to the
> drivers/cpuidle directory.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/{mach-at91/pm.h => include/asm/at91_pm.h} |    0
include/linux/at91_pm.h
>  arch/arm/mach-at91/cpuidle.c                       |    2 +-
>  arch/arm/mach-at91/pm.c                            |    2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/arm/{mach-at91/pm.h => include/asm/at91_pm.h} (100%)
sorry I've patch in the quere that touch this part so you will have to wait

Best Regards,
J.
