From: ccross@android.com (Colin Cross)
Date: Thu, 22 Dec 2011 11:22:29 -0800
Subject: [PATCH v2 06/15] ARM: local timers: switch tegra to standalone
 smp_twd
In-Reply-To: <1324574865-5367-7-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <1324574865-5367-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAMbhsRQUznxdihVv-_oYqfKYHxQLJjcjAFmnWC2gM+7AD8e06Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 9:27 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Convert the Tegra-2 platforms to the standalone version
> of smp_twd.c. Since the timer calibration code requires another
> timer to be up and running, the actual initialisation is left
> to the late_timer_init hook.
>
> Tested on Harmony.
>
> Cc: Colin Cross <ccross@android.com>
> Cc: Erik Gilling <konkers@android.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Colin Cross <ccross@android.com>
