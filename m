From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 Dec 2011 16:31:52 +0900
Subject: [PATCH 09/12] ARM: EXYNOS: introduce
 arch/arm/mach-exynos/common.[ch]
In-Reply-To: <088101ccc1d8$d2023b00$7606b100$%kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <1324385316-6052-10-git-send-email-kgene.kim@samsung.com>
 <20111223191935.GS2577@n2100.arm.linux.org.uk>
 <088101ccc1d8$d2023b00$7606b100$%kim@samsung.com>
Message-ID: <08f401ccc469$9a93a800$cfbaf800$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Russell King - ARM Linux wrote:
> >

> > It looks like there's some changes made to exynos stuff between -rc1
> 
> Yes, some bug has been fixed after -rc1...
> 

Hi Russell,

It is not a bug fix after -rc1 in mainline and the changes are from Marc's
commit db0d4db2 ("ARM: gic: allow GIC to support non-banked setups") and
Axel's bug fixes on Marc's patch which are in your devel-stable branch.

If this patch is not on top of Marc's patch, you can meet conflicts when you
merge the reset branch. Nevertheless, I'm sending the cleaned patch(7257/1
and 7258/1) which can be applied based on your restart-cleanup so that you
can apply this easily anyway and in addition, you can apply other
patches(7254/1, 7255/1 and 7256/1) as well.

I think, expected conflicts when you merge your branches can be fixed and if
any problems, please let me know.

As a note, since local common.[ch] which are not based on current samsung
tree have been introduced, we will meet conflicts between this series and my
tree and of course, I will fix then.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
