From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 17:36:34 -0500
Subject: [PATCH] ARM: Dove: add fixed regulator for CuBox USB power
In-Reply-To: <1356646919-2974-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1356646919-2974-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130112223634.GK13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 11:21:59PM +0100, Sebastian Hesselbarth wrote:
> CuBox needs to enable USB power on a gpio pin. Add a fixed regulator
> to always enable usb power on boot.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove-cubox.dts |   25 ++++++++++++++++++++++++-
>  arch/arm/mach-dove/Kconfig       |    2 ++
>  2 files changed, 26 insertions(+), 1 deletion(-)

Applied to mvebu/dt

thx,

Jason.
