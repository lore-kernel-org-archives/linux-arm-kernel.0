From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri, 3 Feb 2017 09:56:18 -0800
Subject: [PATCH v3 00/24] i.MX Media Driver
In-Reply-To: <2201157.ylZrBapgio@avalon>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1485941457.3353.13.camel@pengutronix.de>
 <8e577a3f-8d44-9dde-9507-36c3769228b6@gmail.com> <2201157.ylZrBapgio@avalon>
Message-ID: <e2ddd5a9-e3a3-5f1d-72a8-3b82bee316ea@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/03/2017 06:41 AM, Laurent Pinchart wrote:
> Hello,
>
> On Wednesday 01 Feb 2017 16:19:27 Steve Longerbeam wrote:
>> On 02/01/2017 01:30 AM, Philipp Zabel wrote:
>>
>>> media-ctl propagates the output pad format to all remote subdevices'
>>> input pads for all enabled links:
>>>
>>> https://git.linuxtv.org/v4l-utils.git/tree/utils/media-ctl/libv4l2subdev.c
>>> #n693
>> Ah cool, I wasn't aware media-ctl did this, but it makes sense and
>> makes it easier on the user.
> To be precise, userspace is responsible for propagating formats *between*
> subdevs (source to sink, over a link) and drivers for propagating formats *in*
> subdevs (sink to source, inside the subdev).

Hi Laurent, yes thanks for that clarification.

Steve
