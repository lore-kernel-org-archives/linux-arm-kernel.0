From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 13 Dec 2016 15:53:50 +0200
Subject: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
In-Reply-To: <b34f49c8-6b37-cabf-2a0f-c8d465c53159@xs4all.nl>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <c956e27e-7e01-2a2f-0e35-796c4a6556ae@xs4all.nl>
 <b34f49c8-6b37-cabf-2a0f-c8d465c53159@xs4all.nl>
Message-ID: <CAJKOXPdEy5N3qR3YGWJi41wD3uRDONmd16gC5LuayZ4_krT6YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 2:34 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> Try again, this time with Krzysztof's new email address...
>
>
> On 13/12/16 13:20, Hans Verkuil wrote:
>>
>> Hi Krzysztof,
>>
>> This still seems to be broken with the latest 4.9 kernel, right?
>>
>> Has there been any progress on this? Do you have an updated patch series
>> for me to use?

Hi,

I think it is not fixed. Still. I left this work to others. AFAIK,
Peter Chen is working on a new generic approach:
https://lwn.net/Articles/703556/
On top of his patchset, Odroid would need some DTS code as well (and
maybe something in usb3503). However I do not plan to work on this
anymore as I do not have Odroid U3 anymore. Marek and Bartlomiej from
Samsung Poland are in CC-list so maybe they would like to continue the
work?

Best regards,
Krzysztof
