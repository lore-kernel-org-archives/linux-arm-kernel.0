From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 9 Jan 2013 21:17:45 -0500
Subject: [PATCH 3/3] ARM: Dove: add Cubox sdhci card detect gpio
In-Reply-To: <1355790269-10596-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1355790269-10596-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1355790269-10596-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130110021745.GG5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 01:24:29AM +0100, Sebastian Hesselbarth wrote:
> Card detect for sdhci on Cubox is connected to the wrong pin
> (sdio1_cd instead of sdio0_cd). With support for cd-gpios and
> pinctrl add the corresponding properties to DT for Cubox.
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
>  arch/arm/boot/dts/dove-cubox.dts |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
