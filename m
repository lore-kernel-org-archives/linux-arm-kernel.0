From: julian.calaby@gmail.com (Julian Calaby)
Date: Tue, 23 Jun 2015 00:54:41 +1000
Subject: [linux-sunxi] [PATCH 1/4] ARM: dts: sunxi: Add regulator-boot-on
 to usb host port regulator nodes
In-Reply-To: <5587C720.9040007@redhat.com>
References: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
 <1434814810-26285-2-git-send-email-hdegoede@redhat.com>
 <CAGRGNgU7179K408=PekziP9ZzzG7+rvhm=e7TWjZk1UhkAnVZQ@mail.gmail.com>
 <5587C720.9040007@redhat.com>
Message-ID: <CAGRGNgXrXgGXhLAQYXVVyG98NbJF4bDE5OWM9TSgYzZYkOR29g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Mon, Jun 22, 2015 at 6:28 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 22-06-15 02:30, Julian Calaby wrote:
>>
>> Hi Hans,
>>
>> On Sun, Jun 21, 2015 at 1:40 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> u-boot will have turned on the power to the usb host ports, so mark them
>>> as regulator-boot-on, this stops the power on the ports from temporarily
>>> getting turned off during boot, causing issues with e.g. usb powered
>>> harddisks.
>>
>>
>> Stupid question: shouldn't u-boot set this property?
>
>
> We could make u-boot set this property but that will require a lot of code
> on
> u-boot's side which is simply not there atm. And traditionally this property
> is is simply a part of the dts files as shipped with the kernel.

Fair enough.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
