From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 25 Nov 2015 14:39:44 +0000
Subject: [RFC PATCH 00/10] Support for Cortex-M Prototyping System
In-Reply-To: <20614077.l46PyO8gV6@wuerfel>
References: <1448447621-17900-1-git-send-email-vladimir.murzin@arm.com>
 <20614077.l46PyO8gV6@wuerfel>
Message-ID: <5655C830.7020501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/15 11:22, Arnd Bergmann wrote:
>> I'd be happy to hear any feedback/comments on this series!
> Looks pretty good overall, I didn't have any specific concerns.

Thanks for your time!

> 
>> > Remain questions:
>> > 
>> >  - Application notes 399/400 have PSRAM located at address different to what
>> >    we have for AN385/AN386, so I'm wondering what is the best practice to handle
>> >    CONFIG_DRAM_BASE? Different defconfig or there is better place?
> I would not want to add more than one defconfig for a relatively simple
> platform. Most actual users would have to modify their config anyway, so
> I think it's best to just have one config file for the most common machine
> here and let users change the dram base if they have the other one.
> 

I think the same, just wanted to check that I didn't misunderstand
something.

> We can also look at using the Kconfig fragments infrastructure more here.
>  
>> >  - I'm not sure about naming of dts files: Application Notes (mps2-an*) vs Cortex-M (mps2-cm*);
>> >    any preference?
> I don't mind either way.

Ok, I'll leave things as they are till anybody has different opinion on
that.

Cheers
Vladimir

> 
> 	Arnd
> 
> 
> 
