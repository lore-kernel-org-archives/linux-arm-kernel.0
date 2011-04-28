From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Apr 2011 22:37:38 +0100
Subject: [PATCH] ARM: The mandatory barrier rmb() must be a dsb() in for
	device accesses
In-Reply-To: <20110428184538.GL17290@n2100.arm.linux.org.uk>
References: <20110325101651.27120.56045.stgit@e102109-lin.cambridge.arm.com>
	<AANLkTi=vx7fttc0B08dcfB_s9ya-98Rt-=a8Hr0QGvsM@mail.gmail.com>
	<1301412104.583.85.camel@e102109-lin.cambridge.arm.com>
	<BANLkTi=SgC3sT5aHpFc8Yi-JZrc1PPcVwA@mail.gmail.com>
	<BANLkTi=37p-BWpzF2KT4J8PO+xEWrRjDfA@mail.gmail.com>
	<BANLkTikcy_eut-HGexziTnoUcXOPLdyVfA@mail.gmail.com>
	<BANLkTin4rfDMUB-Fa=AsL==SfJgaY0C2Zw@mail.gmail.com>
	<BANLkTimh_TD-6gvbYC4UBCmqvkH8DpbKpQ@mail.gmail.com>
	<20110428184538.GL17290@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinpDetPeHhTxo-TdgG65xCTkx3JbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, 28 April 2011, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> So, what am I supposed to do with 6870/1 (rmb) and the wmb patch?
> One or other is wrong - they certainly are not both correct as rmb()
> can not be stronger than wmb().

Given Ming's reply to the wmb patch he posted, you should discard the
wmb patch. As for the rmb one (6870/1), I already explained why it is
needed.

-- 
Catalin
