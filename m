From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 02 Sep 2013 15:25:35 +0200
Subject: [PATCH 1/2] ARM: EXYNOS: convert cpuidle driver to be a platform
 driver
In-Reply-To: <522455E3.4020500@linaro.org>
References: <86136702.IKrZfWSsO8@amdc1032> <522455E3.4020500@linaro.org>
Message-ID: <196900375.6gVKreRJct@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 02, 2013 11:09:55 AM Daniel Lezcano wrote:
> On 08/30/2013 12:15 PM, Bartlomiej Zolnierkiewicz wrote:
> > ARM EXYNOS cpuidle driver is currently not multiplatform support ready
> > (as it uses device_initcall() for initialization and doesn't check on
> > what platform it is running). Fix it by converting the driver to be
> > a platform driver and registering exynos_cpuidle platform device from
> > exynos[4,5]_dt_machine_init().
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Tomasz Figa <t.figa@samsung.com>
> > Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> > ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Queued up for 3.13, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
