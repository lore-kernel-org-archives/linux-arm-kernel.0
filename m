From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 3 Aug 2013 07:54:42 +0400
Subject: [PATCH 00/10] ARM: clps711x: Initial DT support / Fixes
In-Reply-To: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130803075442.6d1a418eb60217f7196a25fc@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Jul 2013 22:34:51 +0400
Alexander Shiyan <shc_work@mail.ru> wrote:

> Here is next patchset for the Cirrus Logic CLPS711X target CPUs.
> The first four patches is a small fixes. The rest is a attempt
> to add DT support for this subarch.
> As long as DT support is incomplete (no peripherals), I did not
> add DTS yet. This is the next step.
> 
> Alexander Shiyan (10):
>   ARM: clps711x: Remove the special name for the syscon driver
>   ARM: clps711x: Drop fortunet board support
>   ARM: clps711x: autcpu12: Remove incorrect config checking
>   ARM: clps711x: edb7211: Remove extra iotable_init() call
>   ARM: clps711x: Add CLPS711X clk driver
>   ARM: clps711x: Add CLPS711X clocksource driver
>   ARM: clps711x: Add CLPS711X irqchip driver
>   ARM: clps711x: Add CLPS711X cpuidle driver
>   ARM: clps711x: Migrate CLPS711X subarch to the new basic drivers
>   ARM: clps711x: Add initial DT support
[...]

If there is no objection about "fixes" part of patchset,
can these parts (1/10-4/10) be applied?
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
