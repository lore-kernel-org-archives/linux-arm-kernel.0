From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 1 Sep 2010 12:45:18 +0100
Subject: [PATCH 00/13] ARM: S5P64X0: Add new S5P6450 Support
In-Reply-To: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100901114518.GA20737@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 04:09:07PM +0900, Kukjin Kim wrote:
> This patches add basic support for Samsung S5P6450 SoC.
> 
> Basically this patch moves mach-s5p6440 (ARCH_S5P6440) to mach-s5p64x0
> (ARCH_S5P64X0) to support Samsung's new S5P6450 SoC. The ARCH_S5P64X0
> can support S5P6440 and S5P6450 with one kernel image. It is tested on
> SMDK6440(S5P6440) and SMDK6450(S5P6450) with s5p64x0_defconfig. And
> this patch changes s5p6440_defconfig to s5p64x0_defconfig for S5P64X0.

What about the s5p6442?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
