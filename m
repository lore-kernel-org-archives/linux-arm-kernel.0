From: jemmajones81@yahoo.co.uk (Jemma Jones)
Date: Thu, 3 May 2012 14:35:55 +0100 (BST)
Subject: Development tree for Cortex-A15?
In-Reply-To: <bc6e93f98278125c354282f23751b1aa@localhost>
References: <1336046199.46241.YahooMailNeo@web132501.mail.ird.yahoo.com>
 <bc6e93f98278125c354282f23751b1aa@localhost>
Message-ID: <1336052155.37772.YahooMailNeo@web132504.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: Development tree for Cortex-A15?

> 
> On Thu, 3 May 2012 12:56:39 +0100 (BST), Jemma Jones
> <jemmajones81@yahoo.co.uk> wrote:
> 
> Hi Jemma,
> 
>>  Hi, I'm looking for the latest KVM-enabled developer version of the
> Linux
>>  kernel for ARM on the Versatile Express board with the Cortex-A15 CPU.?
> 
> It really depends on what you call "developer version". As far as I 
> know,
> there is nothing but dev trees around ;-).
> 
>>  I have pulled from these two trees
>> 
>> 
> http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-arm-arch.git;a=summary
>> 
> http://git.kernel.org/?p=linux/kernel/git/maz/arm-platforms.git;a=summary
>> 
>>  But it seems the 2nd one is more up-to-date with KVM enablement while it
>>  doesn't have any support for the A15 VE board? And the 1st one 
> doesn't
>>  support KVM on ARM with the ARMv7 virtualization extensions?
> 
> First, my tree (the second one) does support the A15. Otherwise I'd have a
> hard time testing my own code... Which branch are you looking at? Please
> note that the KVM branches in this tree are under heavy development, and
> are only suitable if you don't mind frequent rebases and regular breakage
> due to bleeding edge code.

I'm currently on kvm-arm-v7-ael, because it looked like the most up-to-date one. Which one should I be using for Cortex-A15 support?

Thanks.
