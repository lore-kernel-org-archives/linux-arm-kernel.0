From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 04:44:58 -0700
Subject: [PATCH] ARM: dts: DRA7: fix unit address of second PCIe instance
In-Reply-To: <f79ded6b0b41c8e13f8f396d47f9522e5471d327.1465484975.git.nsekhar@ti.com>
References: <f79ded6b0b41c8e13f8f396d47f9522e5471d327.1465484975.git.nsekhar@ti.com>
Message-ID: <20160610114457.GI22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sekhar Nori <nsekhar@ti.com> [160609 08:16]:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> The unit address of the second PCIe instance
> is set to be same as that of the first instance
> (copy-paste error).

Applying into omap-for-v4.8/dt thanks.

Tony
