From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 23:29:17 +0200
Subject: [PATCH soc v8 0/3] ARM: vf610m4: Add Vybrid Cortex-M4 support
In-Reply-To: <12f1cde68eef7d4e35646e83aabae5c3@agner.ch>
References: <1432073032-26561-1-git-send-email-stefan@agner.ch>
 <12f1cde68eef7d4e35646e83aabae5c3@agner.ch>
Message-ID: <2317971.r85DvjF4GE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 00:42:21 Stefan Agner wrote:
> On 2015-05-20 00:03, Stefan Agner wrote:
> > This is the soc part of the splitted patchset which enables Cortex-M4
> > support on Vybrid, as discussed in the thread of patchset v7.
> 
> Arnd, forgot to mention that this depends on the irqchip changes merged
> by Thomas, see
> https://lkml.org/lkml/2015/5/19/204

I've pulled that branch into next/soc now and merged your patches on top.
Great job, thanks a lot!

Can you take a look at the branch now and see what needs to be done
for the other three Cortex-M based platforms, to get them to use
ARM_SINGLE_ARMV7M?

	Arnd
