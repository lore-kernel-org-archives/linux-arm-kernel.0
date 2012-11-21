From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 21 Nov 2012 09:11:42 +0530
Subject: [PATCH 9/9] ARM: remove mach .handle_irq for VIC users
In-Reply-To: <1353466713-18967-10-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
 <1353466713-18967-10-git-send-email-robherring2@gmail.com>
Message-ID: <CAOh2x==2kbs1aHOsTj7yUPEnoQJaZJ_m42+QWNoX5oELbXK6zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 8:28 AM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that the VIC initialization sets up the handle_arch_irq pointer, we
> can remove it for all machines and make it static.
>
>  arch/arm/mach-spear3xx/spear300.c      |    2 --
>  arch/arm/mach-spear3xx/spear310.c      |    2 --
>  arch/arm/mach-spear3xx/spear320.c      |    2 --
>  arch/arm/mach-spear6xx/spear6xx.c      |    1 -

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
