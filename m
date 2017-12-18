From: mbrugger@suse.com (Matthias Brugger)
Date: Mon, 18 Dec 2017 12:43:30 +0100
Subject: [PATCH 0/2] Use SPDX-License-Identifier for rockchip devicetree
 files
In-Reply-To: <24788EB1-9868-41E9-B97C-7D85D8C3761D@theobroma-systems.com>
References: <20171215114427.32059-1-klaus.goger@theobroma-systems.com>
 <21020918.S4038j3A1a@diego>
 <CAOFm3uHuwmU1nCcU1MQ9qgGZ0A70ycuoo8XpWcDzgPQFzFRnRA@mail.gmail.com>
 <63058496.Aj9cacRib9@diego>
 <24788EB1-9868-41E9-B97C-7D85D8C3761D@theobroma-systems.com>
Message-ID: <75deea05-b819-c6b9-6e97-860644f907a5@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/15/2017 05:27 PM, klaus.goger at theobroma-systems.com wrote:
>> On 15.12.2017, at 16:20, Heiko St?bner <heiko@sntech.de> wrote:
>>
>> Am Freitag, 15. Dezember 2017, 15:42:48 CET schrieb Philippe Ombredanne:
>>> On Fri, Dec 15, 2017 at 3:28 PM, Heiko St?bner <heiko@sntech.de> wrote:
>>>> Am Freitag, 15. Dezember 2017, 14:45:34 CET schrieb Philippe Ombredanne:
>>>>> Klaus,
>>>>>
>>>>> On Fri, Dec 15, 2017 at 12:44 PM, Klaus Goger
>>>>>
>>>>> <klaus.goger@theobroma-systems.com> wrote:
>>>>>> This patch series replaces all the license text in rockchip devicetree
>>>>>> files text with a proper SPDX-License-Identifier.
>>>>>> It follows the guidelines submitted[1] by Thomas Gleixner that are not
>>>>>> yet merged.
>>>>>>
>>>>>> These series also fixes the issue with contradicting statements in most
>>>>>> licenses. The introduction text claims to be GPL or X11[2] but the
>>>>>> following verbatim copy of the license is actually a MIT[3] license.
>>>>>> The X11 license includes a advertise clause and trademark information
>>>>>> related to the X Consortium. As these X Consortium specfic points are
>>>>>> irrelevant for us we stick with the actuall license text.
>>>>>>
>>>>>> [1] https://patchwork.kernel.org/patch/10091607/
>>>>>> [2] https://spdx.org/licenses/X11.html
>>>>>> [3] https://spdx.org/licenses/MIT.html
>>>>>
>>>>> FWIW, the X11 license name was not always something clearly defined.
>>>>> SPDX calls it clearly MIT which is the most widely accepted name for
>>>>> the corresponding text. And this is also what we have in Thomas doc
>>>>> patches that should be the kernel reference.
>>>>>
>>>>> Also, as a general note, you want to make sure that such as patch set
>>>>> is not merged by mistake until you have collected an explicit review
>>>>> or ack from all the copyright holders involved.
>>>>
>>>> Just for my understanding, is it really necessary to get Acks from _all_
>>>> previous contributors?
>>>>
>>>> I see that Thomas patches moving license texts into the kernel itself do
>>>> not seem to have landed yet, but when the actual license text does _not_
>>>> change and only its location to a common place inside the kernel sources,
>>>> it feels a bit overkill trying to get Acks from _everybody_ that
>>>> contributed to Rockchip devicetrees for the last 4 years.
>>>>
>>>> If we would actually want to change the license I would definitly feel
>>>> differently, but the license text does not change.
>>>
>>> Well you are technically right. But there is a social and politeness
>>> angle to this too. So may be getting the ack of all contributors is
>>> not always needed, but getting it is best and the right to do and at
>>> least getting for the named copyright holders should be there.
>>>
>>> That's only only my take: leaving aside any technical legal issue, say
>>> I would be on the receiving end as one of the holder or contributors:
>>> I would find it really great and nice to have my ack requested. And I
>>> would be a dork not to give it. So I like to do to others the same I
>>> would appreciate done to me (within reason, as I sometimes shoot
>>> myself in the foot ;) )
>>
>> Hehe ... I didn't plan on merging this without ample time for people
>> to either ACK or NAK the change, so was planning on keeping to social
>> protocol ;-) . Just the "all" threw me for a loop.
>>
>> And having that as PATCH without RFC also communicates that people
>> should take a look, as RFC patches are often overlooked.
>>
>> As Klaus seems to have included most people that have contributed in the
>> past, I would guess we should receive any existing complaints about that
>> change :-) .
> 
> I added the full list from the get_maintainers script. Some of the original authors
> got dropped as the current contribution level dropped below the scripts limit.
> I added the missing email addresses from the copyright headers to the CC list. 
> 
> Convenience links to the original patches for the added people:
> 
> https://patchwork.kernel.org/patch/10114845/
> https://patchwork.kernel.org/patch/10114843/
> 

For both patches:
Acked-by: Matthias Brugger <mbrugger@suse.com>
