From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 26 Jun 2012 12:05:53 +0200
Subject: [PATCH v4 3/9] arm: mach-mvebu: add source files
In-Reply-To: <20120626084715.GC25625@lunn.ch>
References: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
 <1340699313-29331-4-git-send-email-gregory.clement@free-electrons.com>
 <20120626084715.GC25625@lunn.ch>
Message-ID: <4FE98981.40903@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2012 10:47 AM, Andrew Lunn wrote:>> +#define ARMADA_370_XP_RESET_OFFSET		  0x60
>> +#define OTHER_MVEBU_RESET_OFFSET		 0x108
>> +#define MVEBU_RSTOUTN_MASK_OFFSET		   0x0
>> +#define   OTHER_MVEBU_RSTOUTN_MASK_RESET_OUT_EN	   0x4
>> +#define   ARMADA_370_XP_RSTOUTN_MASK_RESET_OUT_EN  0x1
>> +#define MVEBU_SYSTEM_SOFT_RESET_OFFSET		   0x4
>> +#define   MVEBU_SYSTEM_SOFT_RESET		   0x1
>> +
>> +#define OTHER_MVEBU_VARIANT	1
>> +#define ARMADA_370_XP_VARIANT	2
>
> Hi Gregory
>

Hi Andrew,

> Rather than OTHER, could you call this ORION?
>

I thought that one purpose of the next mach-mvebu directory, was to
remove the references to orion.

However, I agree that OTHER is not a really good name. We could
consider indeed 'orion' as a legacy name for this subset of' mvebu'.

I don't have a strong opinion about it.

> I think it will then work on Orion5x, dove, kirkwood and mv78xx0.
>
> I will try to test this on Orion5x and Kirkwood.
>

Thank you!

>   Thanks
> 	Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
