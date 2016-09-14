From: John.Youn@synopsys.com (John Youn)
Date: Wed, 14 Sep 2016 11:26:54 -0700
Subject: [PATCH v2 1/6] usb: dwc2: add support for Meson8b and GXBB SoCs
In-Reply-To: <CAOi56cW+zJ8_Gf6xKMyKNk7YB1+MpWHrtmv=+Xxs0PZy9rAXqQ@mail.gmail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-2-martin.blumenstingl@googlemail.com>
 <m24m5ixxyu.fsf@baylibre.com>
 <0d587b46-4c6e-c2ec-a62e-5d0c5a5bd902@synopsys.com>
 <CAOi56cW+zJ8_Gf6xKMyKNk7YB1+MpWHrtmv=+Xxs0PZy9rAXqQ@mail.gmail.com>
Message-ID: <40e49082-3635-5b99-863b-f51f97258864@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/14/2016 11:17 AM, Kevin Hilman wrote:
> On Wed, Sep 14, 2016 at 11:12 AM, John Youn <John.Youn@synopsys.com> wrote:
>> On 9/14/2016 9:11 AM, Kevin Hilman wrote:
>>> Hi John,
>>>
>>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>>>
>>>> From: Jerome Brunet <jbrunet@baylibre.com>
>>>>
>>>> Add compatible strings for amlogic Meson8b and GXBB SoCs with the
>>>> corresponding configuration parameters.
>>>>
>>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>
>>> Are you OK with adding this platform for v4.9?  I know you mentioned
>>> you're working on new bindings to replace the current way, but since
>>> that hasn't been posted AFAICT, it would be nice to get this merged now
>>> and we can help test the new bindings when you're ready.
>>>
>>> If you're OK with that, and with your Ack, I can take merge the driver
>>> changes through the arm-soc tree along with the rest of the DT patches.
>>>
>>
>> Sure. Unfortunately, I wasn't able to complete it for 4.9.
>>
>> You can add my acked-by on this:
>>
>> Acked-by: John Youn <johnyoun@synopsys.com>
> 
> Great, thanks!  I assume you're OK with PATCH 2/2 for the bindings as
> well (at least for now until you rework them?)
> 
> Kevin
> 

Do you mean PATCH 2/6 from this series?

It doesn't seem to add or remove any bindings in dwc2 so I'm fine with
it.

Regards,
John
