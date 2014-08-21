From: dianders@chromium.org (Doug Anderson)
Date: Wed, 20 Aug 2014 21:12:39 -0700
Subject: [PATCH v7 08/11] arm/arm64: Unexport restart handlers
In-Reply-To: <1408495538-27480-9-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-9-git-send-email-linux@roeck-us.net>
Message-ID: <CAD=FV=Ub6ygGnHX7g422+LS=CS-09okQZ-YA-wfz=JdvwgJfkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter,

On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Implementing a restart handler in a module don't make sense
> as there would be no guarantee that the module is loaded when
> a restart is needed. Unexport arm_pm_restart to ensure that
> no one gets the idea to do it anyway.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v7: No change
> v6: No change
> v5: No change
> v4: No change
> v3: No change
> v2: No change
>
>  arch/arm/kernel/process.c   | 1 -
>  arch/arm64/kernel/process.c | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

(FYI: all patches tested by me were tested on rk3288-evb)
