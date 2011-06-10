From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 10 Jun 2011 08:09:09 +0200
Subject: [PATCH] ARM: SAMSUNG: Add support for pre-sleep/post-restore	gpio
	control
In-Reply-To: <4DF13E03.50803@samsung.com>
References: <1303925654-27715-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<00fc01cc0baa$d7d94cb0$878be610$%kim@samsung.com>
	<003b01cc24df$29b841b0$7d28c510$%szyprowski@samsung.com>
	<4DF13E03.50803@samsung.com>
Message-ID: <001f01cc2734$e97e8f70$bc7bae50$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, June 09, 2011 11:41 PM Kukjin Kim wrote:

> On 06/06/11 23:50, Marek Szyprowski wrote:
> > Hello,
> >
> Hi :)
> 
> (snip)
> 
> >
> > This patch lacks stubs for s5p64x0, s5pc100 and exynos4. I will send a
> quick fix
> > soon.
> 
> Oops, I couldn't test it all on my laptop which is so slow :(

In fact the problem was only on exynos4 platform, because both s5p64x0 and
s5pc100 don't support pm at all. I've posted build fix patch for exynos4.
 
Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
