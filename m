From: maz@misterjones.org (Marc Zyngier)
Date: Wed, 23 Dec 2009 09:16:55 +0100
Subject: [PATCH 3/7] ARM: S5P6440: Add IRQ support
In-Reply-To: <000201ca838f$f7d25880$e7770980$%kim@samsung.com>
References: <1261127996-30253-1-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-2-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-3-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-4-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-5-git-send-email-kgene.kim@samsung.com>
	<20091218145347.4ad08b97@life-in-the-fast-lane>
	<000201ca838f$f7d25880$e7770980$%kim@samsung.com>
Message-ID: <20091223091655.0f59ee94@life-in-the-fast-lane>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Dec 2009 14:22:48 +0900
Kukjin Kim <kgene.kim@samsung.com> wrote:

Kukjin,

> > > +#define IRQ_EINT_GROUP8_NR	(11)
> > 
> > Group 8 has interrupts numbered from 3 to 11, so this should read 12.
> According to the UM's '5.10 PORT P Control Registers', it has 11 interrupts
> numbered from 3 to 10. So I think it's right.

Ah, it looks like a documentation bug, then... My UM describes
EINT8[8:11]. Probably yours is more correct.

	M.
-- 
Fast. Cheap. Reliable. Pick two.
