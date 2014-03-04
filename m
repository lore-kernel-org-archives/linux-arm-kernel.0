From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Mar 2014 23:01:57 -0500
Subject: [PATCH v2 1/5] ASoC: kirkwood: prepare new Dove DT Kconfig
 variable
In-Reply-To: <1393662801-17950-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393662801-17950-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140304040157.GE1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 09:33:17AM +0100, Sebastian Hesselbarth wrote:
> DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> DT-only MACH_DOVE Kconfig.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Mark, as requested, this is the ASoC only patch touching Kconfig for
> Marvell Dove to mach-mvebu conversion.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: alsa-devel at alsa-project.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  sound/soc/kirkwood/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
