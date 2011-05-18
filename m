From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 May 2011 17:05:12 +0900
Subject: [PATCH 0/3] ARM: Removing ARCH_S5P6442
In-Reply-To: <20110517183518.GB933@localhost.ucw.cz>
References: <1305162489-25499-1-git-send-email-kgene.kim@samsung.com>
	<20110517183518.GB933@localhost.ucw.cz>
Message-ID: <000e01cc1532$51ee1f90$f5ca5eb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> 
> On Thu 2011-05-12 10:08:06, Kukjin Kim wrote:
> > This patch remvoes mach-s5p6442 directory for ARCH_S5P6442 in arch/arm.
> 
> Why remove it? No users? Broken? ...?
> 
Hmm...do you want to keep it in upcoming mainline?

Actually, it works fine current mainline on smdk6442. Of course, every
features/devices is not supported yet.

I'm not sure how many developers/companies use it current mainline now but
at least as I know, no one would do it soon.

S5P6442 and S5PC100 were selected when I thought about removing
mach-s5pxxxx.
As you know, I got concerns about C100, but 6442 and I agree with their
opinions.

If S5P6442 is really required later, I think, we can implement it with other
S5P64XX :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
