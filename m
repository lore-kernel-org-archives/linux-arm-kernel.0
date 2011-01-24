From: ccross@android.com (Colin Cross)
Date: Sun, 23 Jan 2011 23:31:14 -0800
Subject: [PATCH v2 13/28] ARM: tegra: Add suspend and hotplug support
In-Reply-To: <1295834493-5019-14-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-14-git-send-email-ccross@android.com>
Message-ID: <AANLkTim9s-ZCGT_2gSYGPvNzGOshzhp5umG_jN3D+oTo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 23, 2011 at 6:01 PM, Colin Cross <ccross@android.com> wrote:

<snip>

> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
> index 00a6ba3..0bf1441 100644
> --- a/arch/arm/mach-tegra/Makefile
<snip>

> +obj-$(CONFIG_LOCAL_TIMER) ? ? ? ? ? ? ? += localtimer.o

This needs to be CONFIG_LOCAL_TIMERS
