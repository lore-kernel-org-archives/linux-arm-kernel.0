From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Sep 2015 08:43:17 -0700
Subject: [PATCH v2] ARM: OMAP2+: omap-device: fix race deferred probe of
 omap_hsmmc vs omap_device_late_init
In-Reply-To: <1440775659-21014-1-git-send-email-grygorii.strashko@ti.com>
References: <1440775659-21014-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20150901154317.GJ4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [150828 08:31]:
> Kernel fails to boot 50% of times (form build to build) with
> RT-patchset applied due to the following race - on late boot
> stages deferred_probe_work_func->omap_hsmmc_probe races with omap_device_late_ini.

Applying into omap-for-v4.3/fixes thanks.

Tony
