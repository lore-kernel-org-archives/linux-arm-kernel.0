From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Aug 2017 10:06:18 -0700
Subject: [PATCH] ARM: dts: DRA7: Add pcie1 dt node for EP mode
In-Reply-To: <20170808054024.18507-1-kishon@ti.com>
References: <20170808054024.18507-1-kishon@ti.com>
Message-ID: <20170810170617.GN8569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170807 22:41]:
> Add pcie1 dt node in order for the controller to operate in
> endpoint mode. However since none of the dra7 based boards have
> slots configured to operate in endpoint mode, keep EP mode
> disabled.

Applying into omap-for-v4.14/dt thanks.

Tony
