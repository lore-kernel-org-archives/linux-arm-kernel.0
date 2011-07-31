From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Sun, 31 Jul 2011 23:42:26 +0200
Subject: [PULL] at91 init factorize
In-Reply-To: <20110731034417.GA6255@game.jcrosoft.org>
References: <20110727121156.GK10037@game.jcrosoft.org>
	<201107271647.44015.arnd@arndb.de>
	<20110727233452.GN10037@game.jcrosoft.org>
	<201107281758.27738.arnd@arndb.de>
	<20110730074623.GG25658@game.jcrosoft.org>
	<alpine.LFD.2.00.1107301434160.12766@xanadu.home>
	<20110731034417.GA6255@game.jcrosoft.org>
Message-ID: <4E35CC42.8050403@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2011 05:44 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:39 Sat 30 Jul     , Nicolas Pitre wrote:
>> On Sat, 30 Jul 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>
>>> On 17:58 Thu 28 Jul     , Arnd Bergmann wrote:
>>>> On Thursday 28 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>> The patches look good, but come at an inconvenient time. We're still
>>>>>> in the merge window, so I don't want to add stuff to linux-next yet
>>>>>> that is destined for 3.2, and I have already sent out all the arm-soc
>>>>>> patches for the 3.1 merge window, so I don't really want to send another
>>>>>> round of patches at the last minute.
>>>>> this are waiting ofr 2 release already
>>>>>
>>>>> and was inthe next last release for more than 1 month
>>>>>
>>>>> can we have them merge this time
>>>>
>>>> What I don't understand at all is why you are waiting instead of sending
>>>> a pull request for all that time then. I've repeatedly given announcements
>>>> about the state of the arm-soc tree and asked people to send patches
>>>> they want in 3.1, and you actually sent bug fixes that way earlier
>>>>
>>>> You've had more than enough time before the merge window, and would even
>>>> have made an exception if you had sent your stuff a few hours earlier,
>>>> before I sent everything to Linus.
>>>> Also, the branch you sent me was created on the same day, meaning that
>>>> it can't possibly have had a lot of testing (though it looks harmless
>>>> enough). When you send a pull request, the patches should always be
>>>> based on an -rc or main release to simplify the merge history, and
>>>> it's better not to rebase to the latest one if you already have the
>>>> patches.
>>> sorry but those patch are 4 motnhs old and yes I rebase the branch to the
>>> current linus tree before send the pull request.
>>
>> Please don't do that.  It is best if you keep the same branch content
>> identical to what has been tested and validated for a while.
> except I send time to retest it

Jean-Christophe,

There is nothing to say in addition:
1/ Arnd has been kind enough to pull those changes in his tree (even 
correcting little things)
2/ Arnd has been kind enough to send a late pull request to Linus
3/ Linus has merged those changes in his tree.

So there is only one word to tell to those people: thanks guys!

Yes, and maybe one more thing to tell them: next time we will do better...

Bye,
-- 
Nicolas Ferre
