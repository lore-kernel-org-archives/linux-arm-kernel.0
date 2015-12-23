From: slash.tmp@free.fr (Mason)
Date: Wed, 23 Dec 2015 15:23:32 +0100
Subject: [PATCH v11 0/2] Sigma Designs Tango4 port
In-Reply-To: <7h60zqund8.fsf@deeprootsystems.com>
References: <566FDF53.3030004@sigmadesigns.com>
 <7hr3iexp3e.fsf@deeprootsystems.com> <5679B15F.80106@free.fr>
 <7hoadi6wfw.fsf@deeprootsystems.com> <5679C743.1070000@free.fr>
 <7h60zqund8.fsf@deeprootsystems.com>
Message-ID: <567AAE64.8010603@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/2015 23:31, Kevin Hilman wrote:

> Mason wrote:
> 
>> What is not clear to me is: are you asking me to submit a new defconfig
>> (specific to my platform), or are you saying I need to add the new
>> platform to arch/arm/configs/multi_v7_defconfig
> 
> multi_v7_defconfig, which is what I've been assuming you've been testing
> it with.  Is that correct?

No, I'm not using the Christmas Tree kernel :-)

I needed a small kernel, so I created a config from scratch, just for
my platform (as things were before ARCH_MULTI_V7)

> The latter.  Something like below[1].  Just keep the multi_v7_defconfig
> patch as a separate patch, and we'll take care of the merge conflicts
> when applying to the relevant arm-soc branches.

I'll send the patch ASAP (probably next week).

>> Can I submit the defconfig update as a follow-up patch?
> 
> IMO, it should be part of this series that adds the platform.  That way,
> as soon as it gets merged, it will be automatically build tested by
> various automated builders.  (also note that it would be automatically
> boot tested if I had the hardware as well... hint, hint) ;)

I will contact HQ and ask if they have boards to spare.

Regards.
