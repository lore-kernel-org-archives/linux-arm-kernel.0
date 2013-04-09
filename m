From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 9 Apr 2013 10:14:40 +0200
Subject: [PATCH v2] mfd: remove twelve unused Kconfig symbols
In-Reply-To: <1363770579.1390.82.camel@x61.thuisdomein>
References: <1363732701.1390.45.camel@x61.thuisdomein>
 <20130320082427.GB28775@opensource.wolfsonmicro.com>
 <1363770579.1390.82.camel@x61.thuisdomein>
Message-ID: <20130409081440.GI24058@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wed, Mar 20, 2013 at 10:09:39AM +0100, Paul Bolle wrote:
> Twelve Kconfig symbols, all related to WM8350, WM8351, and WM8352, are
> unused. Commit 19d57ed5a308472a02e773f33c03ad4cb2ec6a9 ("mfd: Remove
> custom wm8350 cache implementation") removed all their (actual) users.
> Remove these symbols too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 0) This version adds Mark's ACK. It is now also sent to the ARM
> maintainers, as Mark suggested.
> 
> 1) Still only eyeball tested.
> 
>  arch/arm/mach-imx/Kconfig     |  2 --
>  arch/arm/mach-s3c64xx/Kconfig |  3 ---
>  drivers/mfd/Kconfig           | 48 -------------------------------------------
>  3 files changed, 53 deletions(-)
Applied to my mfd-next tree, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
