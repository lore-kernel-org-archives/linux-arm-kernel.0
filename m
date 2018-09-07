From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2018 10:14:14 -0700
Subject: [PATCH v2] ARM: omap: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828154433.5693-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828154433.5693-1-robh@kernel.org>
Message-ID: <20180907171414.GL5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [180828 08:48]:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - fix error in format specifier position

Thanks applying into omap-for-v4.20/soc.

Regards,

Tony
