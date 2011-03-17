From: pullip.cho@samsung.com (KyongHo Cho)
Date: Thu, 17 Mar 2011 20:36:15 +0900
Subject: Why don't we have atomic_set_mask()?
Message-ID: <AANLkTi=V5mHHibKftXZ1A+s6xiuqH5X0pqYPMjZod6EV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

arch/arm/asm/atomic.h defines atomic_clear_mask() but its counterpart,
atomic_set_mask() is not defined.

Don't we need it?

Cho KyongHo.
