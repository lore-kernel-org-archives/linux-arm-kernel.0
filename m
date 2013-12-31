From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 31 Dec 2013 16:02:32 +0100
Subject: [PATCH v2 2/5] input: sun4i-ts: Add support for temperature sensor
In-Reply-To: <20131231130006.GW3144@lukather>
References: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
 <1388156399-29677-3-git-send-email-hdegoede@redhat.com>
 <20131228011304.GB14188@core.coreip.homeip.net>
 <20131231130006.GW3144@lukather>
Message-ID: <52C2DC88.3060902@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/31/2013 02:00 PM, Maxime Ripard wrote:
> Hi,
>
> On Fri, Dec 27, 2013 at 05:13:04PM -0800, Dmitry Torokhov wrote:
>> On Fri, Dec 27, 2013 at 03:59:56PM +0100, Hans de Goede wrote:
>>>
>>> +Optional properties:
>>> + - ts-attached: boolean set this to tell the driver that an actual touchscreen
>>> +		is attached and that it should register an input device,
>>> +		without this it only registers the builtin temperate sensor
>>
>> I believe the guidance is to avoid describing kernel behavior in DT
>> property so I think it should say:
>>
>>   - ts-attached: boolean indicating that an actual touchscreen is
>> 		attached to the controller.
>
> Custom properties are also supposed to be prefixed by the vendor prefix.

Will fix for v3.

Regards,

Hans
