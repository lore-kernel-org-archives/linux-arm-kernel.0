From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 22 Jul 2016 09:21:07 +0200
Subject: [PATCH v6 1/2] [media] atmel-isc: add the Image Sensor Controller
 code
In-Reply-To: <bc8fc3da-9fe0-71ee-e55a-4d8c50b10cd3@microchip.com>
References: <1469088900-23935-1-git-send-email-songjun.wu@microchip.com>
 <1469088900-23935-2-git-send-email-songjun.wu@microchip.com>
 <3ad06658-1e5f-2cd0-f092-4d8f50b4aaa6@xs4all.nl>
 <bc8fc3da-9fe0-71ee-e55a-4d8c50b10cd3@microchip.com>
Message-ID: <ebd3617c-ad3c-d0e0-e024-b72924b5f864@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/22/2016 07:18 AM, Wu, Songjun wrote:

<snip>

>>> +/*
>>> + * index(0~11):  raw formats.
>>> + * index(12~12): the formats which can be converted from raw format by ISC.
>>> + * index():      the formats which can only be provided by subdev.
>>> + */
>>> +static struct isc_format isc_formats[] = {
>>
>> static const
>>
> Some members in structure isc_format need be modified, so it can not be 
> const.

OK. Please add a comment about that.

Regards,

	Hans
