From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Apr 2014 19:28:30 -0400
Subject: commit b3a977b224 {ARM: Better virt_to_page() handling} breaks
 Keystone boot
Message-ID: <53487A9E.70805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The subject commit breaks Keystone boot with higher address space enabled.
I haven't debugged it further but reverting that patch makes it boot again.

I will further look at it on Monday, but thought of letting you know.

Regards,
Santosh
