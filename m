From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 Jan 2015 17:52:48 +0100
Subject: [GIT PULL] at91: fixes for 3.19 #1 (bis)
In-Reply-To: <8332277.8EH8fqiOd7@wuerfel>
References: <1420456477-18204-1-git-send-email-nicolas.ferre@atmel.com>
 <20150111211215.GC25777@quad.lixom.net> <54B3E35E.50400@atmel.com>
 <8332277.8EH8fqiOd7@wuerfel>
Message-ID: <54B3FBE0.6020603@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/01/2015 16:59, Arnd Bergmann a ?crit :
> On Monday 12 January 2015 16:08:14 Nicolas Ferre wrote:
>> Le 11/01/2015 22:12, Olof Johansson a ?crit :
>>> On Fri, Jan 09, 2015 at 10:02:50AM +0100, Nicolas Ferre wrote:
>>>> Le 08/01/2015 23:41, Olof Johansson a ?crit :
>>>>> On Mon, Jan 05, 2015 at 12:14:37PM +0100, Nicolas Ferre wrote:
>>>>>
>>>>> This is the only fix among these patches, isn't it? The others seem to
>>>>> be code removals/cleanups better targeted for 3.20, as far as I can tell.
>>>>
>>>> Well, this is why I sent the first version of this pull-request very
>>>> early in the process. I didn't have the possibility to re-send it
>>>> earlier on top of -rc1 until this pull-request.
> 
> I think this was a bit of a communication problem. I thought about
> applying the first pull request you sent for this, but then Kevin
> commented that it would be better to rebase it on top of -rc1.
> That made sense at the time, except then we all got caught by
> surprise by Christmas and suddenly it was -rc4 ;-)

Exactly, by surprise like every year ;-)

>>> Since you mention that you have more fixes coming (why hold off on them?), do
>>> you want me to cherry-pick over that one fix to our fixes branch, or can you
>>> queue it with the other fixes when you send them up?
>>
>> Fair enough, I build a new "at91: fixes for 3.19 #1 (ter)" with tree
>> more patches right now.
> 
> This seems for the best now. This kind of late cleanup that depends on
> multiple branches going in first happens occasionally and it's never
> nice whichever way you try to handle it.
> 
> The only recommendation I have for the future is to discuss the merge
> strategy with us before the merge window instead of holding back patches
> that have other dependencies. I don't really mind merging them as a
> late branch into -rc1 if I know about them, but we should never plan
> to merge any non-bugfix patches later than -rc2.

Sure. I'll try to do better next time.
I began to create the at91-3.20-cleanup branch with this late material
and all will be fine anyway.

Thanks, bye.
-- 
Nicolas Ferre
