From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 14 Oct 2016 15:28:30 +0200
Subject: [PATCH v2 0/2] Assign RK3066 clocks at boot time
In-Reply-To: <cover.1476447057.git.paweljarosz3691@gmail.com>
References: <cover.1476447057.git.paweljarosz3691@gmail.com>
Message-ID: <1569308.lsrqUgJ5m1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 14. Oktober 2016, 14:16:21 CEST schrieb Pawe? Jarosz:
> This patchset sets rk3066 PLL, CPU and PERI clocks while kernel init.
> 
> Pawe? Jarosz (2):
>   clk: rockchip: Add bindings for cpu and peri clocks on rk3066
>   ARM: dts: rockchip: initialize rk3066 PLL clock rate

changes look good. One thing to keep in mind is that we need clock-id 
additions in a separate patch (as they need to be on a shared branch).

I can do this split of patch1 on my own here, so no need to resend the series 
and will do that after 4.9-rc1 (probably somewhere after sunday) as I need a 
stable base for that shared branch.


Heiko
