From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Jul 2014 20:10:57 -0400
Subject: [PATCH] ARM: dts: dove: add DT LCD controllers
In-Reply-To: <E1XAKGS-0004WE-8h@rmk-PC.arm.linux.org.uk>
References: <E1XAKGS-0004WE-8h@rmk-PC.arm.linux.org.uk>
Message-ID: <20140725001057.GB23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 03:45:00PM +0100, Russell King wrote:
> Add the DT fragment for the Marvell Dove LCD controllers.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Jason,
> 
> David Airlie has taken the Armada DRM changes into his tree, so the DT
> bits can now be queued for the next merge window.
> 
>  arch/arm/boot/dts/dove.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied to mvebu/dt with Sebastian's Ack.

thx,

Jason.
