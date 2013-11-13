From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 13 Nov 2013 10:27:35 -0500
Subject: [PATCH V3 3/7] ARM: DTS: DRA: Add crossbar device binding
In-Reply-To: <1383657257-3458-4-git-send-email-r.sricharan@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
 <1383657257-3458-4-git-send-email-r.sricharan@ti.com>
Message-ID: <52839A67.10802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 November 2013 08:14 AM, Sricharan R wrote:
> This adds the irq crossbar device node.
> 
> There is a IRQ crossbar device in the soc, which
> maps the irq requests from the peripherals to the
> mpu interrupt controller's inputs. The Peripheral irq
> requests are connected to only one crossbar
> input and the output of the crossbar is connected to only one
> controller's input line. The crossbar device is used to map
> a peripheral input to a free mpu's interrupt controller line.
> 
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
