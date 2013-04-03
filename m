From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 03 Apr 2013 14:05:52 -0700
Subject: [PATCH v2 14/18] ARM: OMAP4: CPUidle: Make C-state description
 field more precise
In-Reply-To: <1364205910-32392-15-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:06 +0530")
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-15-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87vc83s4sv.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> It is useful to know the CPU power state along with MPUSS power state
> in a supported C-state. Since the data is available via sysfs, one can
> avoid scrolling the source code for precise construction of C-state.
>
> Reported-by: Nishanth Menon <nm@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Nice.

Adding to for_3.10/fixes/cpuidle branch.

Kevin
