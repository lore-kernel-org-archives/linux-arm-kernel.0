From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 26 Aug 2010 08:23:57 +0900
Subject: [PATCH RE-SEND] ARM: S5P: Move OneNAND device definitions in
	plat-s5p
In-Reply-To: <AANLkTi=V52VyR7ydy6CPChsn0Qp0jW0G0x=ozroDBZYo@mail.gmail.com>
References: <1282522043-2420-1-git-send-email-kgene.kim@samsung.com>
	<01ba01cb4268$8346fa50$89d4eef0$%park@samsung.com>
	<006001cb426b$e84dd560$b8e98020$%kim@samsung.com>
	<AANLkTi=V52VyR7ydy6CPChsn0Qp0jW0G0x=ozroDBZYo@mail.gmail.com>
Message-ID: <001301cb44ac$9a4c0c90$cee425b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Mon, Aug 23, 2010 at 11:35 AM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> > Kyungmin Park wrote:
> >>
> >> " Note: S5PC110 and S5PC210 have same OneNAND driver."
> >>
> >> Yes I also think it's same device. At least Spec is same. But I heard
it
> > has
> >> some different feature related with DMA operation.
> >> I'm not yet receive the official release from LSI. So I can't tell the
> > exact
> >> one.
> >>
> >> If it's true. we need to separate it if required.
> >>
> > No need to separate this stuff.
> > It means that no problem to use this commonly for S5PC110 and S5PC210.
> As DMA operation is changed, we need to register onenand device
> separately like s5pc210-onenand.
> to use the different read operations.
> 
I'm not sure why we need separate platform data even though changed DMA
operation.
Anyway, maybe you received information that we can use this on S5PC110 and
S5PC210.

> >
> > But...I will check it again before applying.
> >
> >> Thank you,
> >> Kyungmin Park
> >>
> >> -----Original Message-----
> >> From: Kukjin Kim [mailto:kgene.kim at samsung.com]
> >> Sent: Monday, August 23, 2010 9:07 AM
> >> To: linux-arm-kernel at lists.infradead.org;
> > linux-samsung-soc at vger.kernel.org
> >> Cc: ben-linux at fluff.org; Kukjin Kim; Kyungmin Park
> >> Subject: [PATCH RE-SEND] ARM: S5P: Move OneNAND device definitions in
> >> plat-s5p
> >>
> >> This patch moves OneNAND device definitions from mach-s5pv210 to
plat-s5p
> >> so that can support it commonly.
> >>
> >> Note: S5PC110 and S5PC210 have same OneNAND driver.
> >>
> >> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >> Cc: Kyungmin Park <Kyungmin Park <kyungmin.park@samsung.com>
> >> ---
(snip)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
