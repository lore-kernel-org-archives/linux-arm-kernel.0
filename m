From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Nov 2011 15:16:38 +0000
Subject: [GIT PULL] VIC DT+MULTI_IRQ_HANDLER patches
In-Reply-To: <20111111151040.GF5114@totoro>
References: <20111111123007.GD5114@totoro>
 <CAJuYYwTsS65LR9_H+VK99-nJggYTmg45p=OX0gDBY=UURQZjHA@mail.gmail.com>
 <20111111151040.GF5114@totoro>
Message-ID: <4EBD3C56.1090407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/11 15:10, Jamie Iles wrote:
> On Fri, Nov 11, 2011 at 08:31:26PM +0530, Thomas Abraham wrote:
>> Hi Jamie,
>>
>> On 11 November 2011 18:00, Jamie Iles <jamie@jamieiles.com> wrote:
>>> Hi Marc,
>>>
>>> I've updated the VIC series to include export.h and added some Tested-by
>>> and Acked-by's.
>>>
>>> This is dependent on https://lkml.org/lkml/2011/11/10/186 (irq: fix
>>> possible null-pointer deref irq_domain_to_irq) which hasn't been picked
>>> up yet so I understand if you don't want to hold up your GIC patches,
>>> but I'll defer to you on that!
>>>
>>> Thanks,
>>>
>>> Jamie
>>>
>>> The following changes since commit ad2cf1a746915c5c95edaba104dcb50023fb18d1:
>>>
>>>  ARM: GIC: Make MULTI_IRQ_HANDLER mandatory (2011-11-08 10:10:10 +0000)
>>>
>>> are available in the git repository at:
>>>  git://github.com/jamieiles/linux-2.6-ji.git vic-dt
>>>
>>> Jamie Iles (11):
>>>      ARM: vic: device tree binding
>>>      ARM: vic: MULTI_IRQ_HANDLER handler
>>>      ARM: ep93xx: convert to MULTI_IRQ_HANDLER
>>>      ARM: netx: convert to MULTI_IRQ_HANDLER
>>>      ARM: nomadik: convert to MULTI_IRQ_HANDLER
>>>      ARM: spear: convert to MULTI_IRQ_HANDLER
>>>      ARM: u300: convert to MULTI_IRQ_HANDLER
>>>      ARM: versatile: convert to MULTI_IRQ_HANDLER
>>>      ARM: samsung: convert to MULTI_IRQ_HANDLER
>>>      ARM: picoxcell: convert to MULTI_IRQ_HANDLER
>>>      ARM: VIC: remove non MULTI_IRQ_HANDLER support
>>
>> There was a patch "[PATCHv4 07/13] ARM: s3c64xx: convert to
>> MULTI_IRQ_HANDLER" in your series. Is this patch dropped in this pull
>> request?
> 
> Crap, that should be there.  When I was rebasing and adding your 
> Tested-by, git did say something about a bad reference but it all looked 
> OK so I thought it was fine.
> 
> Marc, would you mind redoing the pull to get the correct series.  
> Unfortunately I had to rebase to keep it bisectable.

Pulled and pushed out.

	M.
-- 
Jazz is not dead. It just smells funny...
