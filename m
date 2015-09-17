From: slash.tmp@free.fr (Mason)
Date: Thu, 17 Sep 2015 19:22:41 +0200
Subject: Recent GIC v1 patch
In-Reply-To: <55FAEB4D.30306@arm.com>
References: <55FAE26A.9040609@free.fr> <55FAEB4D.30306@arm.com>
Message-ID: <55FAF6E1.7020107@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/2015 18:33, Marc Zyngier wrote:
> Hi Mason,
> 
> On 17/09/15 16:55, Mason wrote:
>> Hello Thomas, Marc,
>>
>> Mans pointed me to a recent patch of yours.
>> irqchip/gic: Use IRQD_FORWARDED_TO_VCPU flag
>> Get rid of the handler_data abuse.
>>
>> I'm using a Cortex A9 based SoC. The platform's interrupt
>> controller is cascaded into the GIC. I've been trying to
>> get this to work for two weeks with no success.
>>
>> Details can be found here:
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/440327
>>
>> Do you think your patch my help with my situation?
> 
> Not sure. A GICv1 shouldn't use EOImode==1 at all, so I don't quite see
> how you end-up there. Also, you seem to be using 4.2, and this code only
> landed during the 4.3 merge window.

Sorry for being unclear. I'm having problems /without/ the patch,
and Mans suggested I try the patch.

>> Do you have any idea what might causing the problem?
> 
> Not without more information, I'm afraid.

Being the unimaginative type, I provided boot log, .config,
full port source code, and device tree description. Can you
explain what kind of information would be required to identify
the problem? (Maybe that would help me diagnose the problem.)

Regards.
