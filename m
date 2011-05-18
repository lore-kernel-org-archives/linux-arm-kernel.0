From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 May 2011 17:56:32 +0900
Subject: [PATCH 0/7] ARM: Removing ARCH_S5PC100
In-Reply-To: <000901cc13e9$1a9a2880$4fce7980$%szyprowski@samsung.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
	<201105131555.42860.anarsoul@gmail.com>
	<000901cc13e9$1a9a2880$4fce7980$%szyprowski@samsung.com>
Message-ID: <001501cc1539$7d663070$78329150$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
Hi :)

> On Friday, May 13, 2011 2:56 PM Vasily Khoruzhick wrote:
> 
> > On Thursday 12 May 2011 04:11:07 Kukjin Kim wrote:
> > > This patch remvoes mach-s5pc100 directory for ARCH_S5PC100 in
arch/arm.
> >
> > Hm, what's the point of removing this code?
> 
> May I also ask the same? What's the point in removing WORKING support for
> the whole SoC series? There are some S5PC100 based boards available on the
> market and they are still being used for embedded Linux development.
> 
> The issues with ARM kernel tree is not about the number of supported
> SoCs/sub-platform but the fact that a lots of code is somehow duplicated
> between different arm sub-architecture. The goal is to identify such code
> and unify it. There have been a lot of discussion about this on Linaro
> Meeting in Budapest. For more information please take a look at etherpad
> notes available here:
> 
> http://summit.ubuntu.com/uds-o/track/linaro-kernel/
> 
> (etherpad links for each session are available via 'notepad' image near
> the session title).
> 
> I recommend to read all the notes from all five 'Arm Linus Interface'
> sessions.
> 

I think, we already discussed about this :)
Hope please refer other my reply on this thread.

Ok, will check about discussion result in last UDS.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
