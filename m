From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Aug 2018 08:34:30 -0700
Subject: [PATCH] pinctrl: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-40-robh@kernel.org>
Message-ID: <20180828153430.GM7523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [180828 01:59]:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
...
>  drivers/pinctrl/pinctrl-single.c              | 32 +++++++++----------
>  drivers/pinctrl/ti/pinctrl-ti-iodelay.c       |  8 ++---

Acked-by: Tony Lindgren <tony@atomide.com>
