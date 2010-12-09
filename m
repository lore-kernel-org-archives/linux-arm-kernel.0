From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Wed, 8 Dec 2010 18:09:38 -0600
Subject: [PATCH 1/6] OMAP: device: make rt_va easily avaialable to drivers
In-Reply-To: <1291852462-3509-1-git-send-email-omar.ramirez@ti.com>
References: <1291852462-3509-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <AANLkTim-R-dLBq29Tf-yg0fC6MhpQ2-zQ1Q14wU+-QCm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 8, 2010 at 5:54 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Patch "OMAP: hwmod/device: add omap_{device, hwmod}_get_mpu_rt_va"[1],
> introduces omap_device_get_rt_va which is meant to be called
> by drivers to retrieve the _mpu_rt_va, however this function
> receives a pointer to an omap_device; since there is no
> practical way for a driver to get this parameter without
> fiddling with pdev and container_of macro, and omap_device code
> already does this, it is better for it to handle this case.
>
> Also moved header declaration to appear in the set of
> functions to be used by drivers, as per the comment there.
>
> [1] http://marc.info/?l=linux-omap&m=127808467703366&w=2
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> ?arch/arm/plat-omap/include/plat/omap_device.h | ? ?3 +--
> ?arch/arm/plat-omap/omap_device.c ? ? ? ? ? ? ?| ? ?8 ++++++--
> ?2 files changed, 7 insertions(+), 4 deletions(-)

This is a single patch set, please ignore the [1/6] subject :/

I'll resubmit to avoid confusions.

Regards,

Omar
