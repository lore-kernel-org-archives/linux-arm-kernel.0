From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 08 May 2015 13:05:43 +0900
Subject: [PATCH] clk samsung exynos5420 add CLK_RECALC_NEW_RATES flag to
 mout_apll and mout_kpll clock.
In-Reply-To: <CANAwSgT8aa5svHgLbkNkSPXWT_hLez8e4cBws2ajEB9p56WHFA@mail.gmail.com>
References: <1431020935-5025-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPcCc8j=i5FPdF62bGKar74+4U=C9BPN9ar2j52Y8dSMwA@mail.gmail.com>
 <CANAwSgT8aa5svHgLbkNkSPXWT_hLez8e4cBws2ajEB9p56WHFA@mail.gmail.com>
Message-ID: <554C3617.10906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.05.2015 13:01, Anand Moon wrote:
> Hi Krysztof,
> 
> Actually the patch is based on https://lkml.org/lkml/2015/4/3/389
> I don't know how to measure the energy consumption when compared to
> cpufreq-exynos.

It does not have to be energy consumption. It may be something else
visible, like wrong values for clock rates. I don't know, it is your
patch so you should know *what is fixed* (or changed).

Best regards,
Krzysztof
