From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Fri, 04 Mar 2011 11:09:50 +0000
Subject: [RFC PATCH 13/20] ARM: msm: dynamically register local timer
	setup function
In-Reply-To: <8ya62rzlsol.fsf@huya.qualcomm.com>
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
	<1299084806-16546-14-git-send-email-marc.zyngier@arm.com>
	<8ya62rzlsol.fsf@huya.qualcomm.com>
Message-ID: <1299236990.10633.62.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-03 at 14:56 -0800, David Brown wrote:
> On Wed, Mar 02 2011, Marc Zyngier wrote:
> 
> > diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> >  }
> >  
> > -inline int local_timer_ack(void)
> > +static inline int mem_local_timer_ack(void)
> >  {
> >  	return 1;
> >  }
> 
> Mispelled 'msm'.

Damned. Thanks, will fix.

> Basic sanity test seems to be working at least on UMP.  Currently
> testing SMP.

Thanks for that. Please let me know how SMP goes.

Cheers,

	M.
-- 
Reality is an implementation detail.
-- 
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
