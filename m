From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 29 Jan 2018 14:39:38 +0100
Subject: [Patch v7 12/12] Documention: v4l: Documentation for HEVC CIDs
In-Reply-To: <1517231702.29374.13.camel@smitha-fedora>
References: <1516791584-7980-1-git-send-email-smitha.t@samsung.com>
 <CGME20180124112406epcas2p3820cea581731825c7ad72ebbb1ca060c@epcas2p3.samsung.com>
 <1516791584-7980-13-git-send-email-smitha.t@samsung.com>
 <127cfd7f-113f-6724-297c-6f3c3746a8ff@xs4all.nl>
 <1517229778.29374.9.camel@smitha-fedora>
 <f1ea8bcc-30b9-06b5-b815-e76fecc22a8a@xs4all.nl>
 <1517231702.29374.13.camel@smitha-fedora>
Message-ID: <3a746ca1-728f-f32f-a4b9-df99f2784c2b@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2018 02:15 PM, Smitha T Murthy wrote:
>>>>
>>> The values set in V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP and
>>> V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP will give the limits for the L0-L6 QP
>>> values that can be set.
>>
>> OK. If you can clarify this in the documentation, then I can Ack this.
>>
>> Note: if userspace changes MIN_QP or MAX_QP, then the driver should call
>> v4l2_ctrl_modify_range() to update the ranges of the controls that are
>> impacted by QP range changes. I'm not sure if that's done at the moment.
>>
>> Regards,
>>
>> 	Hans
>>
>>
> I can mention for all these controls range as
> [V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP, V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP].
> Will this be ok?

Yes, that sounds good.

	Hans
