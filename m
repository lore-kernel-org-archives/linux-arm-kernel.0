From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 12 May 2014 12:25:16 +0530
Subject: [PATCH v3 0/4] ARM: dts: enable display for peach-pit and snow
 boards
In-Reply-To: <CAPdUM4Pg1ERqQ0W8u3nzZzHq0q2Lrk+vKJUdLdWZd8YrhrqsOg@mail.gmail.com>
References: <1399630186-22610-1-git-send-email-rahul.sharma@samsung.com>
 <CALt3h7-zRZp0HWE8VHUmnovfNESfu6c8f=4xScNRV1ZZcP_1vA@mail.gmail.com>
 <CAPdUM4Pg1ERqQ0W8u3nzZzHq0q2Lrk+vKJUdLdWZd8YrhrqsOg@mail.gmail.com>
Message-ID: <CAPdUM4PjD2+HkpcDjXzov7EZWuywg6AiYd_t62yzU0qhWHZ34A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun, Jingoo Han,

On 12 May 2014 09:36, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> On 12 May 2014 09:33, Arun Kumar K <arun.kk@samsung.com> wrote:
>> Hi Rahul,
>>
>> On Fri, May 9, 2014 at 3:39 PM, Rahul Sharma <rahul.sharma@samsung.com> wrote:
>>> From: Rahul Sharma <Rahul.Sharma@samsung.com>
>>>
>>> Add nodes for fimd and dp controller for exynos5250 based snow
>>> and exynos5420 based peach-pit board.
>>>
>>
>> It would be great to include the display support for 5800 peach-pi board also
>> in this series. Most of the values would remain the same except for the changes
>> for bigger display in peach-pi.
>>
>
> Sure. I will post v4 with 5800-drm patches.
>

I posted these patches separately at
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg30475.html

Regards,
Rahul Sharma.

>> Regards
>> Arun
>>
>>> This series is based on Kukjin Kims, for-next branch.
>>>
>>> V3:
>>> 1) Dropped 1 patch "ARM: dts: move dp hpd line to the board file for
>>>  exynos5420".
>>> 2) Extra blank lines for readability.
>>> 3) dp hpd gpio name change (dp_hpd -> dp_hpd_gpio)
>>>
>>> V2:
>>> 1) Rebase on Peach-pit dependent patches.
>>>
>>> It is dependent on
>>> 1) Andrew Bresticker's patch for hpd gpio addition, avilable at
>>> http://www.spinics.net/lists/linux-samsung-soc/msg28827.html [Patch is 'ACK'ed.]
>>> 2) Arun's patch for adding peach-pit board dts file at
>>> http://www.spinics.net/lists/linux-samsung-soc/msg30103.html. [Patch is 'ACK'ed.]
>>>
>>> Rahul Sharma (4):
>>>   ARM: dts: enable fimd for exynos5250 based snow board
>>>   ARM: dts: enable dp-controller for exynos5250 based snow board
>>>   ARM: dts: enable fimd for exynos5420 based peach-pit board
>>>   ARM: dts: enable dp-controller for exynos5420 based peach-pit board
>>>
>>>  arch/arm/boot/dts/exynos5250-snow.dts      |   35 ++++++++++++++++++++++++
>>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   41 ++++++++++++++++++++++++++++
>>>  2 files changed, 76 insertions(+)
>>>
>>> --
>>> 1.7.9.5
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
