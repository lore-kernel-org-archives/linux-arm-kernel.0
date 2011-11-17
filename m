From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 17 Nov 2011 11:00:18 +0800
Subject: [PATCH] arm: omap2: fix build failure
In-Reply-To: <87mxc61kpw.fsf@ti.com>
References: <1320726849-11854-1-git-send-email-tom.leiming@gmail.com>
 <87mxc61kpw.fsf@ti.com>
Message-ID: <CACVXFVMtaiFiKSRh8geVpOzymtZsaUKc9tDHfgJYR57N+RQZ-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 9, 2011 at 3:24 AM, Kevin Hilman <khilman@ti.com> wrote:
> tom.leiming at gmail.com writes:
>
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> The patch fixes the compile failure:
>>
>> ? CC ? ? ?arch/arm/mach-omap2/cpuidle34xx.o
>> arch/arm/mach-omap2/cpuidle34xx.c:317:12: error: 'THIS_MODULE'
>> undeclared here (not in a function)
>> make[1]: *** [arch/arm/mach-omap2/cpuidle34xx.o] Error 1
>> make: *** [arch/arm/mach-omap2] Error 2
>> make: *** Waiting for unfinished jobs....
>>
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>
> FYI...
>
> Tony has already queued fix for this in his fixes branch.
>
> ? ? http://marc.info/?l=linux-arm-kernel&m=132071036621713&w=2

The fix is not merged into 3.2.0-rc2-next-20111116+ yet...

thanks,
-- 
Ming Lei
