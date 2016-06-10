From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 05:10:14 -0700
Subject: [PATCH] ARM: DRA7: hwmod: Remove QSPI address space entry from
 hwmod
In-Reply-To: <1463376303-22267-1-git-send-email-vigneshr@ti.com>
References: <1463376303-22267-1-git-send-email-vigneshr@ti.com>
Message-ID: <20160610121013.GN22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vignesh R <vigneshr@ti.com> [160515 22:27]:
> QSPI address space information is passed from device tree. Therefore
> remove legacy way of passing address space via hwmod data.

Applying this one into omap-for-v4.8/soc thanks.

Tony
