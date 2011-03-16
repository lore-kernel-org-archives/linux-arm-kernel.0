From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 16 Mar 2011 14:59:42 +0900
Subject: [PATCH 0/2] ARM: EXYNOS4: Enhancement of System MMU
In-Reply-To: <AANLkTin7w=KYuLYS=vtcQo3nbLAxJPxLTQCTRGt9x6VL@mail.gmail.com>
References: <1299460768-4077-1-git-send-email-pullip.cho@samsung.com>
	<011701cbe315$e9677140$bc3653c0$%kim@samsung.com>
	<AANLkTin7w=KYuLYS=vtcQo3nbLAxJPxLTQCTRGt9x6VL@mail.gmail.com>
Message-ID: <001801cbe39f$5b307a40$11916ec0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> > Cc'ed Marek.
> >
> > As I said before, Marek's SystemMMU driver has some problems.
> >
> > One is that it allocates 4MB virtual memory at once. It is really a
problem
> > because, the device memory manager must knows the peculiarity and
handles
> > it. Otherwise, page tables can be overwritten...
> 
> Are there device drivers using system MMU at mainline? or example codes?
> In case of Marek's patches, he posted drivers codes and tested at
> multimedia stack.
> 
> Another one is what's the difference between MFC drivers case and
SystemMMU
> one?
> 
This driver does not have dependency on other device drivers, I thought.

> and I hope you read this mail thread.
> http://www.mentby.com/Group/linux-kernel/patch-maintainers-update-msm-
> maintainers.html
> 
> Cite from Linus words.
> Actually, "the community" (not that there really is any such cohesive
> thing) generally asks that vendors be "involved". Not that vendors be
> "exclusively in control". There's a big difference.
> 
Already I read his comments at that time.

> I feel you control the s5p codes for vendor purpose.
> 
I'm afraid that you think so. I will try my best to advancement of Linux.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
