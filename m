From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 30 Aug 2011 00:00:16 -0600
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel Summit
	2011
Message-ID: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updated attendee list:
Confirmed:
1) Nicolas Pitre - arm-soc tree maintainer
2) Arnd Bergmann - arm-soc tree maintainer
3) Olof Johansson - tegra maintainer
4) David Brown
5) Marek Vasut - Various pxa boards maintainer
6) Ohad Ben-Cohen
7) Sascha Hauer
8) Paul Walmsley
9) Catalin Marinas
10) Kukjin Kim - Samsung SoC maintainer
11) Kyungmin Park - Samsung SoC maintainer
12) Mark Brown - ASoC maintainer
13) Grant Likely

Waiting for confirmation:
14) Pavel Machek
15) Eric Miao - pxa/mmp maintainer
16) Haojian Zhuang - pxa/mmp maintainer
17) Nicolas Ferre - Atmel maintainer
18) Will Deacon - ARM engineer

Nominates, but haven't responded personally:
19) Russell King
20) Lennert Buytenhek
21) Marc Zyngier
22) Linus Walleji

We're pretty close to filling up.  Is there anyone else I should include?

Agenda proposals (Thanks to Nicolas and Olof):
- DT bindings for GPIO and pin mux
- the pin mux subsystem from linusw (especially if it is still RFC by
 then)
- progress with the single zImage work
- presentation/status of the DMA and memory management work wrt CMA
 (some SOC specific hacks should go away once this is available)
- DT porting progress
- boot architecture status
- Report from Arnd on experiences from first arm-soc merge window
  - what worked well and where's room for improvement?
  - Any particular SoC workflow that should be tuned to make his life easier?
  - Where are the gaps where he needs help right now?
  - How did it work out for the SoC maintainers?

Still accepting more proposals.  Send me the topics you are burning to discuss.

g.

On Fri, Aug 19, 2011 at 6:02 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Hi all,
>
> It looks like there is definitely enough interest on this, so we're
> going ahead and scheduling a workshop for the first day of kernel
> summit. ?Space is limited however, so I need to assemble a confirmed
> attendee list. ?It looks like we've got room for about two dozen
> people.
>
> So, if you are an ARM subarchitecture maintainer (or generally
> involved with ARM maintainership) and you want to attend, then please
> email me ASAP. ?Attendance confirmation will be first come, first
> serve. ?Here is the list of people that I'm holding a space for
> because they have already expressed interest. ?If you are on this list
> then please let me know in the next week whether or not you are still
> able to attend. ?Also, if you think of anyone who really needs to be
> there, but isn't on this list, then email me to nominate them. ?I'll
> add any nominations to this list and contact them individually.
>
> Nicolas Pitre
> Arnd Bergmann
> Olof Johansson
> Eric Miao
> David Brown
> Mark Vasut
> Ohad Ben-Cohen
> Sascha Hauer
> Paul Walmsley
> Pavel Machek
> Catalin Marinas
>
> I'm also collecting a topic list, but I'll email that out later when
> I've had a chance to collate it. ?Please continue to send me topics
> you would like to see on the agenda.
>
> g.
>
> On Fri, Aug 5, 2011 at 11:44 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> As many of you know, Kernel Summit this year will be a three day
>> event, with the first day dedicated to kernel subsystem workshops[1].
>> Since Kernel Summit will be co-located with ELC-E which my arm
>> developers will be attending, it is the perfect opportunity to have an
>> ARM maintainers meeting. ?Arnd Bergmann, Nicolas Pitre and I talked
>> about it at Linaro Connect this past week and we're going to work on
>> organising something.
>>
>> However, for it to be successful we need to put together a draft
>> agenda quickly. ?Kernel summit is only 80 days away, and people need
>> time to get approval and organise travel. ?So, if you're interested in
>> attending, then we need to know ASAP. ?Reply to this email if you're
>> interested.
>>
>> We also need proposals for discussion topics relevant to ARM,
>> particularly if it relates to all arm sub-architectures or the
>> maintainership process. ?I'll collate the list of proposals that I
>> receive and try to put together an agenda.
>>
>> As already mentioned, the first day (Sunday Oct 23) is dedicated to
>> workshops, and I think that most of the discussion topics will be
>> covered on that day. ?The invite-only core developers meeting is on
>> the second day (Oct 24) which a few people will be involved with. ?For
>> the rest of the group I'm considering organizing it as a hacking day
>> to start sorting out problems identified/discussed on the first day.
>> The third and final day will be plenary sessions open to participants
>> of all workshops.
>>
>> [1] https://sites.google.com/site/kernelsummit2011/announcements/kickoff
>>
>> Cheers,
>> g.
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
