From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 08 Aug 2013 07:58:59 -0700
Subject: [GIT PULL] ARM: keystone: Few non-critical fixes,
 cleanups for 3.12
In-Reply-To: <1375904298-5899-1-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Wed, 7 Aug 2013 15:38:18 -0400")
References: <1375904298-5899-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87ob98jkjw.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The following changes since commit eb788f43a6c6e6c7a5b2879543b565e4cd452de8:
>
>   ARM: Keystone: Convert device tree file to use IRQ defines (2013-08-05 14:06:24 -0400)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-fixes-non-critical
>
> for you to fetch changes up to eb788f43a6c6e6c7a5b2879543b565e4cd452de8:
>
>   ARM: Keystone: Convert device tree file to use IRQ defines (2013-08-05 14:06:24 -0400)
>
> ----------------------------------------------------------------
> ARM: keystone: non-critical fixes, cleanup for 3.12
>
> Summary of changes:
> 	- Drop unused HAVE_SCHED_CLOCK config option
> 	- Remove now redundant smp_init_cpus call
> 	- Update the smc code to remove dsb and r12 usage
> 	- Convert device tree to use #include and GIC bindings

Pulled into next/fixes-non-critical.

Thanks,

Kevin
