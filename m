From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 20 Jun 2012 16:31:31 +0530
Subject: [PATCH 07/10] ARM: OMAP3: update cpuidle latency and threshold
 figures
In-Reply-To: <1339686361-11526-8-git-send-email-j-pihet@ti.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
 <1339686361-11526-8-git-send-email-j-pihet@ti.com>
Message-ID: <4FE1AD8B.305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 June 2012 08:35 PM, Jean Pihet wrote:
>   		{
>   			.enter		  = omap3_enter_idle_bm,
> -			.exit_latency	  = 3000 + 8500,
> -			.target_residency = 15000,
> +			.exit_latency	  = 4080 + 801,
> +			.target_residency = 215000,
>   			.flags		  = CPUIDLE_FLAG_TIME_VALID,
>   			.name		  = "C6",
>   			.desc		  = "MPU OFF + CORE RET",
>   		},
>   		{
>   			.enter		  = omap3_enter_idle_bm,
> -			.exit_latency	  = 10000 + 30000,
> -			.target_residency = 30000,
> +			.exit_latency	  = 4300 + 13000,
> +			.target_residency = 215000,

Is the target_residency same for both these states?

>   			.flags		  = CPUIDLE_FLAG_TIME_VALID,
>   			.name		  = "C7",
>   			.desc		  = "MPU OFF + CORE OFF",
