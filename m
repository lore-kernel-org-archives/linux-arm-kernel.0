From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Feb 2014 21:00:57 +0000
Subject: [PATCH 2/4] ARM: imx6: build headsmp.o only on CONFIG_SMP
In-Reply-To: <1393422280-22283-2-git-send-email-shawn.guo@linaro.org>
References: <1393422280-22283-1-git-send-email-shawn.guo@linaro.org>
 <1393422280-22283-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20140226210056.GB21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 09:44:38PM +0800, Shawn Guo wrote:
> diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
> index e4b9fed..6e1a56d 100644
> --- a/arch/arm/mach-imx/headsmp.S
> +++ b/arch/arm/mach-imx/headsmp.S
> @@ -15,7 +15,6 @@
>  
>  	.section ".text.head", "ax"

While you're here, can you please fix the above section name.  I think
a .text will do just fine here.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
