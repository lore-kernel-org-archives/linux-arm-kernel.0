From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 11 Jun 2010 16:07:58 +0900
Subject: Pending patches for s5pc110
In-Reply-To: <20100611062300.GY7248@trinity.fluff.org>
References: <AANLkTil0wWSFHpwi58enMhhG7475uUmFoZG6QhRim6Xk@mail.gmail.com>
	<AANLkTimjwSHLiMYFywn3vHZYCbqQCCCh9qE-n3xuYOaq@mail.gmail.com>
	<20100611051521.GV7248@trinity.fluff.org>
	<AANLkTikJQnDEjVunmiCLGaVAnj5bR7JdsUZYJ9xAEdE5@mail.gmail.com>
	<20100611062300.GY7248@trinity.fluff.org>
Message-ID: <AANLkTimnuN9h-qka3pRlmaEsR8o6IzFgl3A2YQ5Y28HJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 11, 2010 at 3:23 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, Jun 11, 2010 at 02:38:56PM +0900, Kyungmin Park wrote:
>> On Fri, Jun 11, 2010 at 2:15 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>> > On Fri, Jun 11, 2010 at 01:25:18PM +0900, Kyungmin Park wrote:
>> >> Hi,
>> >>
>> >> No comments mean it's okay then we will prepare the patches to git pull.
>> >
>> > No. no comments means that people either haven't had time to sort
>> > them out or in fact ON HOLIDAY.
>>
>> but you usually missed our patches frequently. with this reason our
>> patches can't merge within proper merge window.
>
> I belive the last set where either being posted just-before or during
> the last merge window. We already had far too much queueud up then and
> we where trying to ensure that the already-queued entries where processed.

Not tell this case, please see the s5pc110 patches last year. last
year we sent the s5pc110 related patches several times. but you don't
give any opinions and can't accept without any reason.

Well it's past story,  forget it.

Last question.

I think you share the s3c maintainer-ship with Kukjin. Can you explain
the criteria?

Thank you,
Kyungmin Park

>
> The last call for updates went out on 13th May, and the two machine
> patches actually turned up on the 30th of May...
>
> It is important that we get these merges ready at least a week in
> advance of the merge window, otherwise there is _no_ time time to test
> the merged trees, and even worse there is little time to correct any
> mistakes... there where I belive two merge problems with trying to
> rebuild trees at the last minute ready to send to Linus.
>
> Unfortunately the S5PC100 moves did get overlooked (I think I may ended
> up dropping off the samsung-soc list) and the ended up producing a lot
> of the work involved in generating the pull request to RMK and then
> Linus. (see http://thread.gmane.org/gmane.linux.kernel.samsung-soc/1427)
>
> If we can organise ourselves better (and Kukjin will be taking over some
> of this work) then maybe we will have a much better experience for the
> next time.
>
>> >
>> >> Thank you,
>> >> Kyungmin Park
>> >>
>> >> On Fri, Jun 4, 2010 at 8:53 AM, Kyungmin Park <kmpark@infradead.org> wrote:
>> >> > Hi ben,
>> >> >
>> >> > There's some pending patches for s5pc110.
>> >> > 1. aquila & goni support files.
>> >
>> > these two should have gone in already
>>
>> I mean more aquila & goni patches. not basic support. e.g. OneNAND
>> support, FB support and so on.
>
> As above, I belive these where rather late on the horizon to be included.
>
>> >> > 2. keypad
>> >
>> > I think kukjin has been looking at this, best check with him.
>>
>> It's already discussed. do you think it needs more comments?
>
> Me, no. I think if Kukjin has no problems then it is up to Dimitry
> whether he wants to merge it.
>
>> >
>> >> > 3. s3c-fb - we have to implement FIMD and MIPI interface so please
>> >> > decide how to handle it.
>> >
>> > since we've not had any chance to discuss what is going on here
>> > I can't see how we are ready to submit anything.
>>
>> It's basic functionality for s3c-fb. it's required for our target and
>> want to use it. even though someone don't use it.
>>
>> I wonder some features are not used for other board. in this case it
>> should be merged if it doesn't break any previous board. Of course
>> with proper feedback. I think we answer your question doesn't it?
>
> The fb system is currently without a propler maintainer and Andrew Morton
> has been doing the job of applying patches. I don't know the reasons for
> the last round of development not going in, but it was probably due to it
> being too late.. I've so far been unable to actually subscribe to the new
> fb list to try and sort it out.
>
> This however doesn't cover the fact that there's been no movement on
> dicsussing what is needed to support FIMC addition to the framebuffer
> driver.
>
> Do you have even a list of things that you think are needed for this, or
> any actual patches we could look at and discuss?
>
> --
> Ben
>
> Q: ? ? ?What's a light-year?
> A: ? ? ?One-third less calories than a regular year.
>
>
