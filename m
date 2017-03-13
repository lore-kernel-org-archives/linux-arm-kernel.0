From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 13 Mar 2017 10:55:19 +0100
Subject: [PATCH v5 21/39] UAPI: Add media UAPI Kbuild file
In-Reply-To: <184c02bf-782d-6dbe-e603-a82ac8dcc8b6@gmail.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-22-git-send-email-steve_longerbeam@mentor.com>
 <20170311134931.GP3220@valkosipuli.retiisi.org.uk>
 <184c02bf-782d-6dbe-e603-a82ac8dcc8b6@gmail.com>
Message-ID: <a1e9f0b2-0dff-db5e-a2a3-5b34230fb1c3@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2017 07:20 PM, Steve Longerbeam wrote:
> 
> 
> On 03/11/2017 05:49 AM, Sakari Ailus wrote:
>> Hi Steve,
>>
>> On Thu, Mar 09, 2017 at 08:53:01PM -0800, Steve Longerbeam wrote:
>>> Add an empty UAPI Kbuild file for media UAPI headers.
>>>
>>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>>
>> The existing V4L2 UAPI headers are under include/uapi/linux. Could you use
>> that directory instead?
>>
>> I actually wouldn't really object doing this but it should have been done in
>> 2002 or so when the first V4L2 header was added. Now the benefit is
>> questionable.
>>
> 
> Agreed, I think the current headers should be moved to uapi/media
> eventually, but for now I'll go ahead and put under uapi/linux.

No, while in staging it shouldn't be exported.

Put it in include/linux and move it to uapi when this driver is mainlined.

I don't think we can move headers from uapi/linux to uapi/media, I'm sure it's
too late for that.

Regards,

	Hans
