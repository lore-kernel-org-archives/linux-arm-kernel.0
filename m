From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 Jan 2017 18:54:19 +0000
Subject: [PATCH v20 00/17] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
Message-ID: <20170123185418.GA961@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 18, 2017 at 09:25:24PM +0800, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer:
>         1. Clean up printk() usage
>         2. Rename the type macros
>         3. Rename the PPI enum & enum values
>         4. Move the type macro and PPI enum into the header file
>         5. Add new enum for SPIs
>         6. Rework PPI determination;

I've taken these few patches onto a preliminary/unstable branch [1].

I haven't had the time to take a look at the rest of the series yet. I
intend to go over that tomorrow, picking what I can, and leaving
feedback for anything that will need rework.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arch-timer/updates
