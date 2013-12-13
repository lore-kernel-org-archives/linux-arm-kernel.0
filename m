From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Fri, 13 Dec 2013 14:55:55 -0700
Subject: [PATCH V1 06/11] ARM: dts: imx6qdl-sabrelite: add gpio-keys
In-Reply-To: <201312132250.45796.marex@denx.de>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <201312131251.13852.marex@denx.de> <52AB55B6.7080104@boundarydevices.com>
 <201312132250.45796.marex@denx.de>
Message-ID: <52AB826B.2030706@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 12/13/2013 02:50 PM, Marek Vasut wrote:
> On Friday, December 13, 2013 at 07:45:10 PM, Troy Kisky wrote:
>> On 12/13/2013 4:51 AM, Marek Vasut wrote:
>>> On Friday, December 13, 2013 at 02:49:10 AM, Troy Kisky wrote:
>>>> Add power, menu, home, back, volume up, and volume down
>>>> buttons.
>>>>
>>>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>>>
>>> Are these really present on the board or are they on some expansion
>>> board? I am not sure how to handle this case when the GPIO buttons are
>>> on optional expansion board, maybe someone else (Shawn?) will help here.
>>>
>>> Best regards,
>>> Marek Vasut
>>
>> You are right, it is an expansion board. But the signals do not conflict
>> with any other
>> expansion board that I know of.
>
> ... yet ;-)
>

I know of a dozen or so folks who are re-purposing these pins
(that's the thing about GPIOs!), but in many cases, they're
doing so by catching the input events matched as this patch
defines them .

And since this is how the schematics and hardware manuals label
the pins, this is the proper way to handle them in the default
kernel.

Regards,


Eric
