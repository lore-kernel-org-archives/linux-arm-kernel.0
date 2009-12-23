From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 23 Dec 2009 20:01:59 +0900
Subject: [PATCH 3/7] ARM: S5P6440: Add IRQ support
In-Reply-To: <20091223091655.0f59ee94@life-in-the-fast-lane>
References: <1261127996-30253-1-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-2-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-3-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-4-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-5-git-send-email-kgene.kim@samsung.com>
	<20091218145347.4ad08b97@life-in-the-fast-lane>
	<000201ca838f$f7d25880$e7770980$%kim@samsung.com>
	<20091223091655.0f59ee94@life-in-the-fast-lane>
Message-ID: <000f01ca83bf$59aaabf0$0d0003d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote:
> On Wed, 23 Dec 2009 14:22:48 +0900
> Kukjin Kim <kgene.kim@samsung.com> wrote:
> 
> Kukjin,
> 
> > > > +#define IRQ_EINT_GROUP8_NR	(11)
> > >
> > > Group 8 has interrupts numbered from 3 to 11, so this should read 12.
> > According to the UM's '5.10 PORT P Control Registers', it has 11
interrupts
> > numbered from 3 to 10. So I think it's right.
> 
> Ah, it looks like a documentation bug, then... My UM describes
> EINT8[8:11]. Probably yours is more correct.

Marc,

Anyway, I will check another our UM.
My UM version is Rev0.10_090728.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
