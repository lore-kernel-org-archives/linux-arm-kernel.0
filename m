From: khilman@ti.com (Kevin Hilman)
Date: Thu, 10 Feb 2011 16:07:47 -0800
Subject: [PATCH v2 5/5] ARM: omap3: Thumb-2 compatibility for sleep34xx.S
In-Reply-To: <87d3mzh6vq.fsf@ti.com> (Kevin Hilman's message of "Thu, 10 Feb
	2011 14:17:13 -0800")
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<1296756161-26092-6-git-send-email-dave.martin@linaro.org>
	<87d3mzh6vq.fsf@ti.com>
Message-ID: <87ei7fe8mk.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> Dave Martin <dave.martin@linaro.org> writes:
>
>>  * Use BSYM() to get the correct Thumb branch address
>>    for adr <Rd>, <label>
>>
>>  * Fix an out-of-range ADR when building for ARM
>>
>>  * Correctly call es3_sdrc_fix as Thumb when copied to SRAM.
>>
>>  * Remove deprecated/undefined PC-relative stores
>>
>>  * Add the required ENDPROC() directive for each ENTRY().
>>
>>  * .align before data words
>>
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>
> I'm attempting to test this series with OMAP PM, but some changes here
> don't compile for me.
>
> My toolchain is: gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) 
>
> First, I merged your arm/omap-thumb2+merged branch with my pm branch
> from git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Sorry for the confusion, this patch should've been in reply to your v4
version, since I merged with your 'arm/omap-thumb2+merged' branch from
today.

Kevin
