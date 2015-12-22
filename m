From: slash.tmp@free.fr (Mason)
Date: Tue, 22 Dec 2015 22:57:23 +0100
Subject: [PATCH v11 0/2] Sigma Designs Tango4 port
In-Reply-To: <7hoadi6wfw.fsf@deeprootsystems.com>
References: <566FDF53.3030004@sigmadesigns.com>
 <7hr3iexp3e.fsf@deeprootsystems.com> <5679B15F.80106@free.fr>
 <7hoadi6wfw.fsf@deeprootsystems.com>
Message-ID: <5679C743.1070000@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/2015 21:49, Kevin Hilman wrote:

> Mason wrote:
> 
>> On 22/12/2015 20:25, Kevin Hilman wrote:
>>
>>> Was it intentional to leave out a multi_v7_defconfig change so that this
>>> actually builds?  Or was that planned for a future series?
>>
>> How is a multi_v7_defconfig different from any old defconfig?
> 
> Not sure what you're asking.
> 
> The point is that this series doesn't enable any defconfig to build it.

What is not clear to me is: are you asking me to submit a new defconfig
(specific to my platform), or are you saying I need to add the new
platform to arch/arm/configs/multi_v7_defconfig (I'm not sure how exactly
to go about doing that; also I'm concerned about merge conflicts, since
my patch set is based on v4.1)

>>> IMO, it should be part of this series so it gets build tested as soon as
>>> it's merged.
>>
>> The problem is that a mandatory driver is missing upstream
>> (interrupt controller).
>>
>> http://thread.gmane.org/gmane.linux.kernel/2089470
> 
> Which means it presumably wont boot without that, but it should still
> build without it, correct?  (I tried it locally, and it does.)

Can I submit the defconfig update as a follow-up patch?

Regards.
