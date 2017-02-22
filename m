From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 22 Feb 2017 09:19:27 -0800
Subject: [PATCH v4 12/36] add mux and video interface bridge entity
 functions
In-Reply-To: <20170219212812.GA28347@amd>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-13-git-send-email-steve_longerbeam@mentor.com>
 <20170219212812.GA28347@amd>
Message-ID: <1fdb3bb6-46fc-40d9-0011-3f53aa2ac899@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/19/2017 01:28 PM, Pavel Machek wrote:
> On Wed 2017-02-15 18:19:14, Steve Longerbeam wrote:
>> From: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> - renamed MEDIA_ENT_F_MUX to MEDIA_ENT_F_VID_MUX
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>
> This is slightly "interesting" format of changelog. Normally signoffs
> go below.
>
>> diff --git a/Documentation/media/uapi/mediactl/media-types.rst b/Documentation/media/uapi/mediactl/media-types.rst
>> index 3e03dc2..023be29 100644
>> --- a/Documentation/media/uapi/mediactl/media-types.rst
>> +++ b/Documentation/media/uapi/mediactl/media-types.rst
>> @@ -298,6 +298,28 @@ Types and flags used to represent the media graph elements
>>  	  received on its sink pad and outputs the statistics data on
>>  	  its source pad.
>>
>> +    -  ..  row 29
>> +
>> +       ..  _MEDIA-ENT-F-MUX:
>> +
>> +       -  ``MEDIA_ENT_F_MUX``
>
> And you probably want to rename it here, too.

Done, thanks.
Steve

>
> With that fixed:
>
> Reviewed-by: Pavel Machek <pavel@ucw.cz>
>
