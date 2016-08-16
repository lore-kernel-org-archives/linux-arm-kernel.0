From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 16 Aug 2016 08:10:56 -0500
Subject: [PATCH v3 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
In-Reply-To: <9cfa549e-1979-cb42-bfe1-1ef347dd3a9a@roeck-us.net> (Guenter
 Roeck's message of "Mon, 15 Aug 2016 18:51:38 -0700")
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
 <1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
 <578271D3.4080704@roeck-us.net> <7hbn237aw7.fsf@baylibre.com>
 <m2bn19qsy3.fsf@baylibre.com>
 <CAOi56cUQaFKYu2jNP0AuLOSNnNramu+DNPc+PH7K0gHDZMf+zA@mail.gmail.com>
 <7hinv1ahqi.fsf@baylibre.com>
 <9cfa549e-1979-cb42-bfe1-1ef347dd3a9a@roeck-us.net>
Message-ID: <m2wpjg97vj.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 08/15/2016 01:40 PM, Kevin Hilman wrote:
>> Kevin Hilman <khilman@baylibre.com> writes:
>>
>>> On Wed, Aug 3, 2016 at 5:27 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>>>> Hi Guenter,
>>>>
>>>> Kevin Hilman <khilman@baylibre.com> writes:
>>>>
>>>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>>>
>>>>>> On 07/10/2016 02:11 AM, Neil Armstrong wrote:
>>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>>
>>>>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>>>>
>>>>>> Would this go in through one of the arm trees ?
>>>>>
>>>>> You can take the driver through the watchdog tree, but I'll take the DT
>>>>> stuff through the amlogic tree (and submit via arm-soc).
>>>>>
>>>>> However, with your ack, and since this is a brand new driver, I could
>>>>> take the driver as well.  Just let me know your preference.
>>>>
>>>> ping... do you have a prefernce here?
>>>>
>>>
>>> Oops, just noticed Wim already picked these up.
>>>
>>
>> Strange, seems that Wim picked up patches 1 & 3, but this one was missed.  I'll
>> queue this for the arm-soc tree.
>>
>
> I got a number of requests from arm maintainers to not pick up devicetree changes
> for arch/arm, so for my part I usually leave those alone.

Yeah, that's the normal way, but Wim replied to the cover letter saying
he would pick up all three, so I got a bit confused.

Anyways, not a big deal.  I'll take it from here.

Kevin
