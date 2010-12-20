From: nm@ti.com (Nishanth Menon)
Date: Mon, 20 Dec 2010 05:44:59 -0600
Subject: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while invalidating
	L2 cache
In-Reply-To: <9b48aafcc94e9b69236ed4d934ebd91e@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-6-git-send-email-nm@ti.com>
	<9b48aafcc94e9b69236ed4d934ebd91e@mail.gmail.com>
Message-ID: <4D0F41BB.2070606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar wrote, on 12/20/2010 01:13 AM:
[..]
>> This is be done according to ARM documentation. Currently this is
>> identified
>> as being needed on OMAP3630 as the disable/enable is done from "public
>> side"
>> while, on OMAP3430, this is done in the "secure side".
> Can you point me to ARM doc which says " for L2 invalidation, the
> controller
> needs to be disabled" ?
please see section 8.3 of the Cortex-A8 TRM


-- 
Regards,
Nishanth Menon
