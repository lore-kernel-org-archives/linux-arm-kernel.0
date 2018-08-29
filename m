From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 29 Aug 2018 10:31:51 +0200
Subject: [PATCH] pinctrl: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-40-robh@kernel.org>
Message-ID: <4627271.TU6sX7boZt@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 28. August 2018, 03:52:41 CEST schrieb Rob Herring:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

>  drivers/pinctrl/pinctrl-rockchip.c            |  8 ++---

For the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>
