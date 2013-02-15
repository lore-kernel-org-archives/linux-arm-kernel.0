From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 15 Feb 2013 16:46:33 -0500
Subject: [PATCH] ARM: Dove: convert usb host controller to DT
In-Reply-To: <1359388448-14370-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1359388448-14370-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130215214633.GG14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 04:54:08PM +0100, Sebastian Hesselbarth wrote:
> With DT support for orion-ehci also convert Dove to it and
> remove the legacy calls and clock aliases.
> 
> This patch is based on "ARM: Dove: split legacy and DT setup"
> applied to mvebu/boards recently.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove.dtsi   |   16 ++++++++++++++++
>  arch/arm/mach-dove/board-dt.c |   10 ----------
>  2 files changed, 16 insertions(+), 10 deletions(-)

Applied to mvebu/dt

thx,

Jason.
