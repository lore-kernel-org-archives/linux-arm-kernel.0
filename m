From: nerv@dawncrow.de (=?ISO-8859-1?Q?Andr=E9_Hentschel?=)
Date: Tue, 12 Feb 2013 15:14:42 +0100
Subject: [PATCH] arm: Preserve TPIDRURW on context switch
In-Reply-To: <20130212140950.GC4123@mudshark.cambridge.arm.com>
References: <5112DC7E.4020108@dawncrow.de>
 <20130206225150.GL17833@n2100.arm.linux.org.uk>
 <5112E0C3.1080706@dawncrow.de>
 <20130208154809.GF3495@mudshark.cambridge.arm.com>
 <511A4B93.1000700@dawncrow.de>
 <20130212140950.GC4123@mudshark.cambridge.arm.com>
Message-ID: <511A4E52.4070909@dawncrow.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.02.2013 15:09, schrieb Will Deacon:
> Hi Andre,
> 
> On Tue, Feb 12, 2013 at 02:02:59PM +0000, Andr? Hentschel wrote:
>> Am 08.02.2013 16:48, schrieb Will Deacon:
>>> On Wed, Feb 06, 2013 at 11:01:23PM +0000, Andr? Hentschel wrote:
>>>> No, i'm not sure how to improve this. How does the process can continue, can you or someone else fix that and add his Signed-off-by?
>>>
>>> How about something like the (completely untested) diff below?
>>>
>>> Andre: if this works for you, I'm happy to write a commit message etc.
>>
>> Thx for your effort, but it doesn't work, at least not with my 3.4.6 suse kernel.
>> Be free to have another try, i'll be happy to test it.
> 
> Well, cheers for testing. Can you be more specific about what goes wrong
> please? What do you see in TPIDRURW?
> 
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Hi Will,

it's 0x00000000 again.

-- 

Best Regards, Andr? Hentschel
