From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri, 9 Jun 2017 17:19:31 -0700
Subject: [PATCH v8 14/34] ARM: dts: imx6-sabreauto: add the ADV7180 video
 decoder
In-Reply-To: <20170609232358.GA14181@amd>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
 <1496860453-6282-15-git-send-email-steve_longerbeam@mentor.com>
 <CAJ+vNU0C0=4hUq+g1P7yTzLzFPidfauQROPOVr4WQWKNZz_xmQ@mail.gmail.com>
 <dd5b29b7-bf92-5f03-caef-1843a9f32cd3@gmail.com> <20170609213843.GB28596@amd>
 <cb9d79e9-fa36-d0ad-3df6-27f1b8790f78@gmail.com> <20170609232358.GA14181@amd>
Message-ID: <f5cad571-9147-1c72-47d9-4e6f68116f97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/09/2017 04:23 PM, Pavel Machek wrote:
> Hi!
> 
>>>>> Steve,
>>>>>
>>>>> You need to remove the fim node now that you've moved this to V4L2 controls.
>>>>>
>>>>
>>>> Yep, I caught this just after sending the v8 patchset. I'll send
>>>> a v9 of this patch.
>>>
>>> This needs ack from devicetree people, then it can be merged. Can you
>>> be a bit more forceful getting the ack?
>>
>> OK, I need an Ack please, he said, in a forceful way. :)
> 
> I'd tune the force up a tiny bit more. This is not FreeBSD ;-). You
> can read some emails from Linus for inspiration. Or drink few beers
> and look at Al Viro's emails.
> 
>> In fact Ack's are needed for all the changes to dts sources,
>> patches 4-14.
> 
> Actually, are they? Those should not need acks from device tree
> people, just acks from ARM people, and those are easier to get... in
> fact they should not need any acks, you should just send them to arm
> people and get them merged.


Hans said he prefers to have the dts patches as part of the whole set
rather than submitted separately. But I did add --to's for the ARM
people for 4-14.


> 
> 1-4 is just a documentation, and you have acks there. (Except 2?)
> That's ready to be merged, probably via the media tree? Just make it
> clear you want it merged.

Yes, 1-3 now have Acks (binding docs).

> 
> 15,16 should be ready to. Media tree, too, I guess.

Yes, those have Acks (video-mux entity functions and subdev driver).

> 
> drivers/staging is greg. Advantage is these do _not_ need to go after
> the dts changes. It is a driver. Actually I'd normally add dts support
> after the driver. So you can push it now.

Right, Hans agrees, except that for staging drivers we don't really need
an Ack from Greg.


> 
>>> I don't think it makes sense to resubmit v9 before that. This is not a
>>> rocket science.
>>
>> I guess that makes sense, I'll wait for Ack's from all these patches
>> before submitting the entire patchset as v9.
> 
> You may want to split the series, according to mainainters, or just
> ask the maintainers to merge the relevant parts. I believe most of it
> can be pushed now.
> 
> Good luck,

Thanks!
Steve
