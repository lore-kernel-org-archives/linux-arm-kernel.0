From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 17:37:06 -0500
Subject: [PATCH] ARM: Dove: move CuBox led pinctrl to gpio-leds node
In-Reply-To: <1356646870-2903-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1356646870-2903-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130112223706.GL13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 27, 2012 at 11:21:10PM +0100, Sebastian Hesselbarth wrote:
> gpio-leds has support for pinctrl allocation, make use of it.
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
>  arch/arm/boot/dts/dove-cubox.dts |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied to mvebu/dt

thx,

Jason.
