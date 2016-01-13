From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Jan 2016 09:19:14 -0800
Subject: [PATCH v2 3/3] pci: dra7xx: use pdata callbacks to perform reset
In-Reply-To: <1452667666-17533-4-git-send-email-kishon@ti.com>
References: <1452667666-17533-1-git-send-email-kishon@ti.com>
 <1452667666-17533-4-git-send-email-kishon@ti.com>
Message-ID: <20160113171913.GH12777@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [160112 22:48]:
> Use platform populated reset assert and deassert
> callbacks to perform reset of PCIe.
> 
> Use these callbacks until a reset interface using drivers/reset
> is available for the purpose.

This one has a dependency to the second patch for the platform
data.

Bjorn, how do you prefer to merge this once there are no more
comments?

How about I set up an immutable branch against v4.5-rc1 with
just these three patches that we can both then merge in?

My preference is to add this to linux next after the merge
window for v4.6. Bjorn, if you want it merged as fixes, I'm
fine with that too naturally.

Regards,

Tony
