From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 22 Feb 2017 15:54:45 -0800
Subject: [PATCH v4 17/36] media: Add userspace header file for i.MX
In-Reply-To: <1487244825.2377.39.camel@pengutronix.de>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-18-git-send-email-steve_longerbeam@mentor.com>
 <1487244825.2377.39.camel@pengutronix.de>
Message-ID: <8f09d9e8-5b98-bfa2-17b5-cc038801d1fc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/16/2017 03:33 AM, Philipp Zabel wrote:
> On Wed, 2017-02-15 at 18:19 -0800, Steve Longerbeam wrote:
>>
>> +/*
>> + * events from the subdevs
>> + */
>> +#define V4L2_EVENT_IMX_CLASS          V4L2_EVENT_PRIVATE_START
>> +#define V4L2_EVENT_IMX_NFB4EOF        (V4L2_EVENT_IMX_CLASS + 1)
>> +#define V4L2_EVENT_IMX_FRAME_INTERVAL (V4L2_EVENT_IMX_CLASS + 2)
>
> These events are still i.MX specific. I think they shouldn't be.

Done, I've exported them to

V4L2_EVENT_FRAME_INTERVAL_ERROR
V4L2_EVENT_NEW_FRAME_BEFORE_EOF

Steve
