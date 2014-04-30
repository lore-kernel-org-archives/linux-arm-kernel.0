From: rajan_srivastava@hotmail.com (Rajan Srivastava)
Date: Wed, 30 Apr 2014 21:04:29 +0530
Subject: ARMv8: Allowing user space to perform cache-maintenance
In-Reply-To: <20140430105820.GA31224@arm.com>
References: <SNT151-W6986D9EAC402142465B4BE8410@phx.gbl>,
 <SNT151-W939A3657D532DA8406405DE8410@phx.gbl>,
 <20140430105820.GA31224@arm.com>
Message-ID: <SNT151-W56573F5C94CEAFC1787DC2E8410@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am referring to ARM for ARMv8-A, "ARM DDI 0487A.a_errata_2013_Q3 (ID100313)", section D8.2.79 'System Control Register (EL1)'.

Thanks,
Rajan


----------------------------------------
> Date: Wed, 30 Apr 2014 11:58:20 +0100
> From: catalin.marinas at arm.com
> To: rajan_srivastava at hotmail.com
> CC: linaro-kernel at lists.linaro.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: ARMv8: Allowing user space to perform cache-maintenance
>
> On Wed, Apr 30, 2014 at 02:01:38PM +0530, Rajan Srivastava wrote:
>> ARMv8 allows AArch64-EL0 to execute cache maintenance instructions
>> (eg, by setting SCTLR_EL1.UCI). It looks like the current ARMv8 kernel
>> doesn't support the above feature.
>
> Where have you looked and came up to this conclusion?
>
> --
> Catalin
 		 	   		  
