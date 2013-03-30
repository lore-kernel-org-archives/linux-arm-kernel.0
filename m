From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 16:55:51 -0400
Subject: [PATCH] ARM: kirkwood: add MACH_GURUPLUG_DT to defconfig
In-Reply-To: <1364043502-17716-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1364043502-17716-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130330205551.GY13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 01:58:22PM +0100, Sebastian Hesselbarth wrote:
> This patch just adds the missing MACH_GURUPLUG_DT to kirkwood_defconfig.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reported-by: Soeren Moch <smoch@web.de>
> ---
> Cc: Soeren Moch <smoch@web.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Stefan Peter <s.peter@mpl.ch>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/configs/kirkwood_defconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/boards

thx,

Jason.
