From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 1 Jul 2014 15:21:19 +0800
Subject: [PATCH 6/9] ARM: dts: sun7i: Add board support for LinkSprite
 pcDuino V3
In-Reply-To: <53B25F60.2050704@redhat.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
 <1404165479-23785-7-git-send-email-hdegoede@redhat.com>
 <CAGb2v65mDnuwveUiTKU2J3b3jbNzRLvPjS+wXNEj2MRtDN4Q2w@mail.gmail.com>
 <53B25F60.2050704@redhat.com>
Message-ID: <CAGb2v64KMxXQ7QaRcsWxHbCLNJtWkh5sxj82C-y9GyNW7R+M_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 3:12 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 07/01/2014 04:22 AM, Chen-Yu Tsai wrote:
>> On Tue, Jul 1, 2014 at 5:57 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> From: Zoltan HERPAI <wigyori@uid0.hu>
>>>
>>> The LinkSprite pcDuino V3 is an A20 based development board featuring
>>> arduino compatible io headers, 1G RAM, 4G nand, sata, rtl8188cus usb wifi
>>> and 100 Mbit ethernet using an ip101a phy:
>>>
>>> http://www.pcduino.com/pcduino-v3/
>>>
>>> Signed-off-by: Zoltan HERPAI <wigyori@uid0.hu>
>>> [hdegoede at redhat.com: Various cleanups, correct led pins]
>>> [hdegoede at redhat.com: Add axp209, ir and gpio-keys nodes]
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> --
>>>
>>> Changes since v2:
>>>  - update MMC entry to comply with upstream
>>>  - unify the 4 patches into one
>>>
>>> Changes since v1:
>>>  - fix cosmetic issues
>>>  - fix i2c entry
>>>  - remove unnecessary input bindings include
>>>  - add MMC support
>>> ---
>>>  arch/arm/boot/dts/Makefile               |   3 +-
>>>  arch/arm/boot/dts/sun7i-a20-pcduino3.dts | 173 +++++++++++++++++++++++++++++++
>>>  2 files changed, 175 insertions(+), 1 deletion(-)
>>>  create mode 100644 arch/arm/boot/dts/sun7i-a20-pcduino3.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index ed0de8b..fdc590e 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -380,7 +380,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>>>         sun7i-a20-cubieboard2.dtb \
>>>         sun7i-a20-cubietruck.dtb \
>>>         sun7i-a20-i12-tvbox.dtb \
>>> -       sun7i-a20-olinuxino-micro.dtb
>>> +       sun7i-a20-olinuxino-micro.dtb \
>>> +       sun7i-a20-pcduino3.dtb
>>
>> You may need to rebase onto my sun8i ippo-q8h dts patch.
>>
>>   https://patchwork.kernel.org/patch/4389951/
>>
>> There's a likely conflict in the Makefile here.
>
> Has that one already been accepted by Maxime ? I'm fine rebasing patches
> on top of accepted stuff, but rebasing on pending stuff is not really
> useful IMHO.

Maxime replied stating he applied it. See the lower part of the patchwork
page.

AFAIK he's accepted my initial sun8i patches and CIR DT patches this cycle.


ChenYu
