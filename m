From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Nov 2011 12:48:47 -0700
Subject: [PATCH v3 10/17] ARM: tegra2: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1320425871-30564-11-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
	<1320425871-30564-11-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAOesGMg7hVL7i=UnW3_fwLasdHvAyi8wb+rLC2pnXvxAw3aSNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 4, 2011 at 9:57 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Convert the tegra2 platforms to be using the gic_handle_irq
> function as their primary interrupt handler.
>
> Tested on harmony.
>
> Cc: Colin Cross <ccross@android.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Hm, the series did require some manual touch up on top of last night's
linux-next, mostly due to fuzz and some exynos changes. That being
said, the tegra parts are still:

Acked-by: Olof Johansson <olof@lixom.net>

(I acked 0/x of the last patch set instead of the individual patch)


-Olof
