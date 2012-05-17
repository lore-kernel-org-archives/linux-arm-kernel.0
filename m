From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 17 May 2012 15:52:13 +0900
Subject: [GIT PULL] Samsung devel-2 for v3.5
In-Reply-To: <CAK9yfHyw81CM6OWvwFCG0jqQLULviUhUrz5bA2gM3h+W25rwfQ@mail.gmail.com>
References: <092f01cd332c$00df3c60$029db520$%kim@samsung.com>
 <201205162013.37031.arnd@arndb.de>
 <CAK9yfHyw81CM6OWvwFCG0jqQLULviUhUrz5bA2gM3h+W25rwfQ@mail.gmail.com>
Message-ID: <0b1601cd33f9$96d66a40$c4833ec0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> Hi Arnd,
> 
> Thomas has posted a patch [1] (available on Grant's tree) to fix this
> problem.
> 
> [1] http://git.secretlab.ca/?p=linux-
> 2.6.git;a=commitdiff;h=766644d2df254934d656a0a0628b636212c24f9e;hp=0034102
> 808e0dbbf3a2394b82b1bb40b5778de9e
> 
> 
Yeah, I know that. But in this case, the Arnd's patch looks better to me and
this helps to avoid build error in current arm-soc. I think, we can cleanup
#ifdef CONFIG_OF in mach-exynos/ when we move on supporting DT for all of
EXYNOS next time.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
