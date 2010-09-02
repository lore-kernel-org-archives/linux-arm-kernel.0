From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 02 Sep 2010 19:21:10 +0900
Subject: [PATCH 00/13] ARM: S5P64X0: Add new S5P6450 Support
In-Reply-To: <20100901114518.GA20737@trinity.fluff.org>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
	<20100901114518.GA20737@trinity.fluff.org>
Message-ID: <005201cb4a88$93214570$b963d050$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> 
Hi ;-)

> On Wed, Sep 01, 2010 at 04:09:07PM +0900, Kukjin Kim wrote:
> > This patches add basic support for Samsung S5P6450 SoC.
> >
> > Basically this patch moves mach-s5p6440 (ARCH_S5P6440) to mach-s5p64x0
> > (ARCH_S5P64X0) to support Samsung's new S5P6450 SoC. The
> ARCH_S5P64X0
> > can support S5P6440 and S5P6450 with one kernel image. It is tested on
> > SMDK6440(S5P6440) and SMDK6450(S5P6450) with s5p64x0_defconfig. And
> > this patch changes s5p6440_defconfig to s5p64x0_defconfig for S5P64X0.
> 
> What about the s5p6442?
> 
S5P6440 and S5P6450 are each other similar, but S5P6442 differs much with
it.
,,,so remains some issues for it now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
