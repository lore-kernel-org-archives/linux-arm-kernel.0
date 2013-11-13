From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 13 Nov 2013 10:29:25 -0500
Subject: [PATCH V3 5/7] ARM: DTS: DRA7: Add routable-irqs property for
 gic node
In-Reply-To: <1383657257-3458-6-git-send-email-r.sricharan@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
 <1383657257-3458-6-git-send-email-r.sricharan@ti.com>
Message-ID: <52839AD5.9090600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 November 2013 08:14 AM, Sricharan R wrote:
> There is a IRQ crossbar device in the soc, which maps the
> irq requests from the peripherals to the mpu interrupt
> controller's inputs. The gic provides the support for such
> IPs in the form of routable-irqs. So adding the property
> here to gic node.
> 
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
