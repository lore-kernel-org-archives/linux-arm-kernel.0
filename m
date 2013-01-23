From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 22 Jan 2013 20:11:25 -0500
Subject: [PATCH] ARM: kirkwood: fix missing #interrupt-cells property
In-Reply-To: <1358883993-17280-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1358883993-17280-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130123011125.GC1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 08:46:33PM +0100, Sebastian Hesselbarth wrote:
> The gpio controller on kirkwood can provide interrupts but is missing
> the #interrupt-cells property. This patch just adds it to both gpio
> controllers.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Jamie Lentin <jm@lentin.co.uk>
> Cc: Jean-Francois Moine <moinejf@free.fr>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/kirkwood.dtsi |    2 ++
>  1 file changed, 2 insertions(+)

Applied to mvebu/fixes

thx,

Jason.
