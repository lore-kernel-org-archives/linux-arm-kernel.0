From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 11 Jun 2010 14:38:56 +0900
Subject: Pending patches for s5pc110
In-Reply-To: <20100611051521.GV7248@trinity.fluff.org>
References: <AANLkTil0wWSFHpwi58enMhhG7475uUmFoZG6QhRim6Xk@mail.gmail.com>
	<AANLkTimjwSHLiMYFywn3vHZYCbqQCCCh9qE-n3xuYOaq@mail.gmail.com>
	<20100611051521.GV7248@trinity.fluff.org>
Message-ID: <AANLkTikJQnDEjVunmiCLGaVAnj5bR7JdsUZYJ9xAEdE5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 11, 2010 at 2:15 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, Jun 11, 2010 at 01:25:18PM +0900, Kyungmin Park wrote:
>> Hi,
>>
>> No comments mean it's okay then we will prepare the patches to git pull.
>
> No. no comments means that people either haven't had time to sort
> them out or in fact ON HOLIDAY.

but you usually missed our patches frequently. with this reason our
patches can't merge within proper merge window.

>
>> Thank you,
>> Kyungmin Park
>>
>> On Fri, Jun 4, 2010 at 8:53 AM, Kyungmin Park <kmpark@infradead.org> wrote:
>> > Hi ben,
>> >
>> > There's some pending patches for s5pc110.
>> > 1. aquila & goni support files.
>
> these two should have gone in already

I mean more aquila & goni patches. not basic support. e.g. OneNAND
support, FB support and so on.
>
>> > 2. keypad
>
> I think kukjin has been looking at this, best check with him.

It's already discussed. do you think it needs more comments?

>
>> > 3. s3c-fb - we have to implement FIMD and MIPI interface so please
>> > decide how to handle it.
>
> since we've not had any chance to discuss what is going on here
> I can't see how we are ready to submit anything.

It's basic functionality for s3c-fb. it's required for our target and
want to use it. even though someone don't use it.

I wonder some features are not used for other board. in this case it
should be merged if it doesn't break any previous board. Of course
with proper feedback. I think we answer your question doesn't it?

Thank you,
Kyungmin Park

>
>> > 4. etc.
>> >
>> > Do you want to re-post or any activities?
>> >
>> > Please give your plans or opinions.
>> >
>> > Thank you,
>> > Kyungmin Park
>> >
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> --
> Ben
>
> Q: ? ? ?What's a light-year?
> A: ? ? ?One-third less calories than a regular year.
>
>
