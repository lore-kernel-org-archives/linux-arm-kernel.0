From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Oct 2017 08:46:10 -0700
Subject: [PATCH 0/2] dra7/omap5: Increase max-voltage of pbias to 3.3v
In-Reply-To: <20171009055312.24165-1-kishon@ti.com>
References: <20171009055312.24165-1-kishon@ti.com>
Message-ID: <20171011154610.GA4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [171008 22:54]:
> Max voltage of pbias was set to 3.0v because of an error in TRM in
> omap5/dra7 SoCs. It's now corrected to be 3.3v.
> 
> Corresponding change in pbias regulator driver is already merged in
> ulf -next
> commit 27eae9d4b9d4cd9c204ef81f46078d91362ed41c

Thanks applying both into omap-for-v4.15/dt.

Regards,

Tony
