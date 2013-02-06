From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Feb 2013 17:01:39 -0800
Subject: [GIT PULL 4/5] Samsung cleanup-s3c24xx-2 for v3.9
In-Reply-To: <120e01ce0331$3aba1ec0$b02e5c40$@samsung.com>
References: <120e01ce0331$3aba1ec0$b02e5c40$@samsung.com>
Message-ID: <20130206010139.GB28722@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 03:42:00PM -0800, Kukjin Kim wrote:
> Hi Arnd and Olof,
> 
> This is 4th cleanup for Samsung S3C24XX stuff, and removes plat-s3c24xx
> directory :-)
> Note, this is based on previous pull-request, 'next/irq-s3c24xx' branch.
> 
> If any problems, please kindly let me know.
> 
> Thanks.
> 
> - Kukjin
> 
> 
> The following changes since commit f44ddba3635e35317057e976888d4a12dcb0f842:
> 
>   ARM: S3C24XX: transform s3c2443 subirqs into new structure (2013-02-03
> 15:52:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/cleanup-s3c24xx-2
> 
> for you to fetch changes up to 37c3adca81b282bdf310d5ed54acbc28ac0b20a3:
> 
>   ARM: S3C24XX: header mach/regs-mem.h local (2013-02-04 10:31:43 -0800)
> 
> ----------------------------------------------------------------
> Kukjin Kim (4):
>       ARM: S3C24XX: Remove plat-s3c24xx directory in arch/arm/

So the previous branch moved some of the irq stuff from mach to plat, and here
you move it from plat to mach. Please avoid extra churn like this in the future
if you can.


-Olof
