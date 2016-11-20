From: slash.tmp@free.fr (Mason)
Date: Sun, 20 Nov 2016 21:00:20 +0100
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <20161120194439.GY1041@n2100.armlinux.org.uk>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk> <582F0DD2.3030805@free.fr>
 <20161119071702.GA25647@afzalpc>
 <20161119110301.GQ1041@n2100.armlinux.org.uk> <58309A02.4030804@free.fr>
 <CAD=FV=WQCfpvVrn64LjxfeG2S7peU5ZWKVGsRyU83-zNCVZmxg@mail.gmail.com>
 <20161120194439.GY1041@n2100.armlinux.org.uk>
Message-ID: <3265ea26-767f-a509-07eb-2f8ce26b90e6@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2016 20:44, Russell King - ARM Linux wrote:

> On Sun, Nov 20, 2016 at 11:18:48AM -0800, Doug Anderson wrote:
>
>> On Sat, Nov 19, 2016 at 10:29 AM, Mason <slash.tmp@free.fr> wrote:
>>
>>> OK, so loop-based delays are known to be short. Would you or Linus
>>> accept a patch that adds a X% cushion *in the implementation* ?
>>>
>>> You are saying "people shouldn't expect udelay(10) to delay at least
>>> 10 ?s, thus they should write udelay(10+N)".
>>>
>>> Why not hide that implementation detail inside the implementation,
>>> so as not to force the pessimization on every other implementation
>>> behind the udelay/ndelay wrapper?
> 
> Try sending Linus a patch for it.

OK, I will.

BTW, any reason why you replied to me via Doug's reply?
Are my messages not reaching your server?

Regards.
