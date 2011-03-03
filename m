From: davidb@codeaurora.org (David Brown)
Date: Thu, 03 Mar 2011 14:56:10 -0800
Subject: [RFC PATCH 13/20] ARM: msm: dynamically register local timer
	setup function
In-Reply-To: <1299084806-16546-14-git-send-email-marc.zyngier@arm.com> (Marc
	Zyngier's message of "Wed, 2 Mar 2011 16:53:19 +0000")
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
	<1299084806-16546-14-git-send-email-marc.zyngier@arm.com>
Message-ID: <8ya62rzlsol.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02 2011, Marc Zyngier wrote:

> diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
>  }
>  
> -inline int local_timer_ack(void)
> +static inline int mem_local_timer_ack(void)
>  {
>  	return 1;
>  }

Mispelled 'msm'.

Basic sanity test seems to be working at least on UMP.  Currently
testing SMP.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
