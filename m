From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 07 Apr 2011 00:45:41 +0200
Subject: [PATCH 1/2] ARM: Differentiate SheevaPlugs and DockStars on the
	basis of the memory size.
In-Reply-To: <alpine.LFD.2.00.1104061739100.28032@xanadu.home>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<1302122121-3652-2-git-send-email-holler@ahsoftware.de>
	<alpine.LFD.2.00.1104061739100.28032@xanadu.home>
Message-ID: <4D9CED15.2010806@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.04.2011 23:44, Nicolas Pitre wrote:
> On Wed, 6 Apr 2011, Alexander Holler wrote:
>
>> It is possible to differentiate a SheevaPlugs and DockStars on the basis
>> of the memory size.
>>
>> This makes it possible to unify both setup files.
>
> No no no !!!  This is an abomination!
>
> We are not going to reduce the amount of code under arch/arm/ with such
> fragile hacks.  This would create an even worse maintenance problem the
> day either of those devices is released with more RAM or whatever.

DockStars are already obsolet and vanilla Linux was never supported by 
the manufacturer (Seagate). And they never used the machine type in 
question.

So I don't think this in any way a fragile hack.

Anyway, it was just a suggestion.

Regards,

Alexander
