From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 4 May 2013 14:35:33 -0400
Subject: [PATCH 1/3] ARM: dove: add DT parsing for legacy mv643xx_eth
In-Reply-To: <1367519140-19716-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367519140-19716-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1367519140-19716-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130504183533.GQ31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 08:25:38PM +0200, Sebastian Hesselbarth wrote:
> To allow to move to orion irqchip driver, existing legacy devices
> have to map their irqs. This patch adds a node for mv643xx_eth and
> some init code to map the corresponding irqs. While the device tree
> node can stay, the init code will vanish as soon as there is true
> device tree support for mv643xx_eth.
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
>  arch/arm/boot/dts/dove.dtsi   |    7 +++++++
>  arch/arm/mach-dove/board-dt.c |   31 ++++++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletions(-)

Please break this into two patches, dtsi in one, board-dt.c in the
other.

thx,

Jason.
