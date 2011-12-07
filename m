From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Dec 2011 16:09:02 -0800
Subject: [RFC PATCH 11/11] arm:omap:am33xx: Add am335x support in generic
 omap_hwmod
In-Reply-To: <1321809555-13833-12-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Sun, 20 Nov 2011 22:49:15 +0530")
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
 <1321809555-13833-12-git-send-email-hvaibhav@ti.com>
Message-ID: <87d3c15jkx.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Rajendra,

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> AM335X is bit different than OMAP3/4 architecture when it comes to
> PRCM module, for example, the way module is enabled/disabled.
> Although it is closer to OMAP4 architecure but the register offset
> and PRCM partitions won't match, so we need to seperate API's
> for AM335X.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Seems like this one can be addressed similarily to the way Rajendra
proposed addressing the powerdomain issue so that OMAP4 code can be
largely reused.

Kevin 
