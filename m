From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 4 May 2013 14:36:24 -0400
Subject: [PATCH 2/3] ARM: dove: add DT parsing for legacy timer
In-Reply-To: <1367519140-19716-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367519140-19716-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1367519140-19716-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130504183624.GR31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 08:25:39PM +0200, Sebastian Hesselbarth wrote:
> To allow to move to orion irqchip driver, existing legacy devices
> have to map their irqs. This patch adds a node for orion timer and
> some init code to map the corresponding irqs. While the device tree
> node can stay, the init code will vanish as soon as there is true
> device tree support for orion timer.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Jean-Francois Moine <moinejf@free.fr>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-doc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove.dtsi   |    7 ++++++
>  arch/arm/mach-dove/board-dt.c |   42 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 43 insertions(+), 6 deletions(-)

Same for the rest of these, please.

thx,

Jason.
