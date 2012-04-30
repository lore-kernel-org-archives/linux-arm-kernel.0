From: khilman@ti.com (Kevin Hilman)
Date: Mon, 30 Apr 2012 16:08:58 -0700
Subject: [PATCH 2/2] ARM: OMAP: PM: remove the latency related functions
 from the API
In-Reply-To: <1334757314-29325-3-git-send-email-j-pihet@ti.com> (jean pihet's
 message of "Wed, 18 Apr 2012 15:55:14 +0200")
References: <1334757314-29325-1-git-send-email-j-pihet@ti.com>
 <1334757314-29325-3-git-send-email-j-pihet@ti.com>
Message-ID: <87lilclsvp.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jean.pihet at newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Remove the following functions from the OMAP PM API:
>  omap_pm_set_max_mpu_wakeup_lat
>  omap_pm_set_max_dev_wakeup_lat
>  omap_pm_set_max_sdma_lat
> and updated the kernel Documentation accordingly.
>
> The generic per-device PM QoS functions shall be used instead of the
> OMAP PM API, cf. include/linux/pm_qos.h and
> Documentation/power/pm_qos_interface.txt.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>
