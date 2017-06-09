From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri, 9 Jun 2017 15:35:26 -0700
Subject: [PATCH v8 14/34] ARM: dts: imx6-sabreauto: add the ADV7180 video
 decoder
In-Reply-To: <20170609213843.GB28596@amd>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
 <1496860453-6282-15-git-send-email-steve_longerbeam@mentor.com>
 <CAJ+vNU0C0=4hUq+g1P7yTzLzFPidfauQROPOVr4WQWKNZz_xmQ@mail.gmail.com>
 <dd5b29b7-bf92-5f03-caef-1843a9f32cd3@gmail.com> <20170609213843.GB28596@amd>
Message-ID: <cb9d79e9-fa36-d0ad-3df6-27f1b8790f78@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/09/2017 02:38 PM, Pavel Machek wrote:
> On Thu 2017-06-08 13:36:12, Steve Longerbeam wrote:
>>
>>
>> On 06/08/2017 01:25 PM, Tim Harvey wrote:
>>>
>>>
>>> Steve,
>>>
>>> You need to remove the fim node now that you've moved this to V4L2 controls.
>>>
>>
>> Yep, I caught this just after sending the v8 patchset. I'll send
>> a v9 of this patch.
> 
> This needs ack from devicetree people, then it can be merged. Can you
> be a bit more forceful getting the ack?

OK, I need an Ack please, he said, in a forceful way. :)

In fact Ack's are needed for all the changes to dts sources,
patches 4-14.


> 
> I don't think it makes sense to resubmit v9 before that. This is not a
> rocket science.

I guess that makes sense, I'll wait for Ack's from all these patches
before submitting the entire patchset as v9.

Steve
