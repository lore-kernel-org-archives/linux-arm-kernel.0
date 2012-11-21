From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 21 Nov 2012 09:12:23 +0530
Subject: [PATCH 6/9] ARM: remove mach .handle_irq for GIC users
In-Reply-To: <1353466713-18967-7-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
 <1353466713-18967-7-git-send-email-robherring2@gmail.com>
Message-ID: <CAOh2x=m+R_09n5qQj-VTYBJ+joi+1hfqPP1LnC==Cmpj9Wx8Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 8:28 AM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that the GIC initialization sets up the handle_arch_irq pointer, we
> can remove it for all machines.

>  arch/arm/mach-spear13xx/spear1310.c        |    1 -
>  arch/arm/mach-spear13xx/spear1340.c        |    1 -

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
