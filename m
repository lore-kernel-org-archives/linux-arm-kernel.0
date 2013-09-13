From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 13 Sep 2013 14:16:06 -0700
Subject: [PATCH v2] drivers: cpuidle: rename ARM big.LITTLE driver config
 and makefile entries
In-Reply-To: <1379086721-5242-1-git-send-email-lorenzo.pieralisi@arm.com>
 (Lorenzo Pieralisi's message of "Fri, 13 Sep 2013 16:38:41 +0100")
References: <1379086721-5242-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <878uz0e82x.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> Following the reorganization of CPU idle drivers configurations into an ARM
> specific Kconfig, the existing idle drivers Kconfig entries were renamed and
> moved to the Kconfig.arm file. Makefile entries were updated accordingly.
>
> This patch renames the entries in Kconfig.arm and makefile to make the newly
> added big.LITTLE CPUidle driver compliant with the new naming convention.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Kevin Hilman <khilman@linaro.org>

We picked up this driver originally through arm-soc (with your signoff)
because of arch/arm dependencies, but you might as well take this one
directly since it's isolated to drivers/cpuidle.

Can you queue this up for v3.12-rc please?

Thanks,

Kevin
