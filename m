From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 11 Mar 2011 12:45:59 +0900
Subject: [PATCH] Exynos4: Add HSMMC channel 4 support
In-Reply-To: <AANLkTimk+GPkxrDx0zG3rMam9OCz9sCL+2n4_c8KwLye@mail.gmail.com>
References: <20110308025340.GA25712@july>
	<00d601cbdf94$59254640$0b6fd2c0$%kim@samsung.com>
	<AANLkTimk+GPkxrDx0zG3rMam9OCz9sCL+2n4_c8KwLye@mail.gmail.com>
Message-ID: <00e801cbdf9e$d934e3e0$8b9eaba0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Fri, Mar 11, 2011 at 11:30 AM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> > Kyungmin Park wrote:
> >>
> >> From: Kyungmin Park <kyungmin.park@samsung.com>
> >>
> >> Exynos4 has the DesignWare Host controller at channel 4.
> >>
> > Yeah, Exynos4210 has it but it can be happened problem when used your
> > approach later.
> > Because, we can't assume hsmmc4 to be used for dw_mmc on other SoCs.
> >
> > I mean, other file, eg., dev-dwmmc.c or dev-dwmci.c should be added for
its
> > platform devices.
> 
> Who's opinions? Please Cc the proper person at LSI. I want to listen
> his opinions.
> 
It's mine.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
