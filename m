From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 14 Feb 2018 09:38:54 +0000
Subject: Support for Cortex R4
In-Reply-To: <CAH9_wRNzj2=pYzhPkGo-cs+UBkgeKE_ieS6oKM_pt22dTxEy9g@mail.gmail.com>
References: <CAH9_wRNzj2=pYzhPkGo-cs+UBkgeKE_ieS6oKM_pt22dTxEy9g@mail.gmail.com>
Message-ID: <15aa2e42-6ef2-850c-2a77-966e3455e18f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/02/18 09:37, Sriram V wrote:
> Hello,
> 
> We are planning to use BCM43907 which has 320MHZ ARM Cortex R4.  This
> is without MMU.

Interesting...

> 
> I wanted to check the extent of support in Linux Kernel for Arm-Cortex R4?
> 
> Does the mainline kernel support boot on ARM-Cortex R4?

I run Linux on Cortex-R7/R8 (SMP and UP configurations) models and I do not
see reasons why it cannot be done for Cortex-R4.

Just bear in mind that Cortex-R is ARMv7, so while defining your board config
select CPU_V7.

Cheers
Vladimir

> 
> 
> Thanks for your help.
> 
> Regards,
> Sriram
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
