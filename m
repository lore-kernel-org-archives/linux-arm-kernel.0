From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Dec 2011 16:24:04 -0800
Subject: [PATCH-V5 0/3] Introducing TI's New SoC/board AM335XEVM
In-Reply-To: <1322808204-12878-1-git-send-email-hvaibhav@ti.com>
 (hvaibhav@ti.com's message of "Fri, 2 Dec 2011 12:13:21 +0530")
References: <hvaibhav@ti.com>
 <1322808204-12878-1-git-send-email-hvaibhav@ti.com>
Message-ID: <87y5up44bf.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<hvaibhav@ti.com> writes:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> This patch set adds support for AM335x device having
> Cortex-A8 MPU.
>
> Official website - http://www.ti.com/product/am3359
>
> AM335X is treated as another OMAP3 variant, where,
> along with existing cpu class OMAP34XX, new cpu class AM33XX is created
> and the respective type is AM335X, which is newly added device in
> the family.
> This means, cpu_is_omap34xx(), cpu_is_am33xx() and
> cpu_is_am335x() checks return success for AM335X.
>
> Also, I have validated OMAP3 boot test with this patch-series on
> OMAP3EVM.

Tony, this series looks good to me.

I've also tested it on a BeagleBone, so feel free to also add:

Tested-by: Kevin Hilman <khilman@ti.com>

Kevin
