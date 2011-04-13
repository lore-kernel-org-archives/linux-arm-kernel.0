From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Apr 2011 07:56:22 +0900
Subject: [PATCH] ARM: S3C64XX: Initial support for Wolfson/Simtec
	Cragganmore/Banff
In-Reply-To: <1302533295-27917-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1302533295-27917-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <01bd01cbfa2e$1afae140$50f0a3c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> The Cragganmore carrier card and Banff CPU module are used on Wolfson
> Microelectronics reference systems.  This initial support covers the
> core system which is a fairly generic S3C6410 based design, further
> patches will add support for the key features of the reference system.
> 
> The initial board bringup and therefore much of the key code was done by
> Ben Dooks for Simtec, with additional work (especially around the
> integration of the Wolfson devices) being done by myself.
> 
> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/Kconfig             |   24 ++
>  arch/arm/mach-s3c64xx/Makefile            |    1 +
>  arch/arm/mach-s3c64xx/include/mach/irqs.h |    4 +-
>  arch/arm/mach-s3c64xx/mach-crag6410.c     |  575
> +++++++++++++++++++++++++++++
>  4 files changed, 603 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-s3c64xx/mach-crag6410.c
> 
(Cc'ing Russell King)

Hi Mark,

Looks ok after quickly review.

But I'm not sure this can be sent to upstream during the next merge window.
Because of Linus' complaint, Russell does not want to add new stuff now,
maybe you know. Basically my tree was sent to upstream via RMK when merge
window.

Hmm...for now I will make some branch for new stuff like this and keep it
until everyone is happy. Of course, if any consolidation work in Linux ARM
world, I will update.

Or...if any good idea, please let me know :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
