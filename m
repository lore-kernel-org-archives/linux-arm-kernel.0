From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Sep 2011 17:32:10 -0700
Subject: [RFC PATCH-V2 0/4] Introducing TI's New SoC/board AM335XEVM
In-Reply-To: <1314621976-25750-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
	<1314621976-25750-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20110915003210.GC30941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* hvaibhav at ti.com <hvaibhav@ti.com> [110829 05:52]:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> This patch set adds support for AM335x device having
> Cortex-A8 MPU.
> 
> AM335X is treated as another OMAP3 variant, where,
> along with existing cpu class OMAP34XX, new cpu class AM33XX is created
> and the respective type is AM335X, which is newly added device in the family.
> This means, cpu_is_omap34xx(), cpu_is_am33xx() and
> cpu_is_am335x() checks return success for AM335X.
> 
> Currently submitting this patch series as a RFC (V2), to initiate the
> discussion on the approach we have chosen for AM335x device support.
> Based on the feedback, will submit the final version of patch series
> immediately.

Can you please rebase these on Paul's CHIP_IS removal series?

Those patches are available at:

git://git.pwsan.com/linux-2.6 omap_chip_remove_cleanup_3.2

Regards,

Tony
