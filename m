From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 6 Jul 2015 14:12:38 +0200
Subject: [linux-sunxi] Re: [PATCH 2/3] ARM: dts: axp152: Add a dtsi file
 for the axp152 pmic
In-Reply-To: <20150706085713.GE3269@lukather>
References: <1435088503-20776-1-git-send-email-hdegoede@redhat.com>
 <1435088503-20776-3-git-send-email-hdegoede@redhat.com>
 <20150625174027.GF2266@lukather> <558D0BC2.10004@redhat.com>
 <20150706085713.GE3269@lukather>
Message-ID: <559A70B6.3010101@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06-07-15 10:57, Maxime Ripard wrote:
> Hi,
>
> On Fri, Jun 26, 2015 at 10:22:26AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 25-06-15 19:40, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Tue, Jun 23, 2015 at 09:41:42PM +0200, Hans de Goede wrote:
>>>> From: Michal Suchanek <hramrach@gmail.com>
>>>>
>>>> Add a dtsi file for the axp152 pmic, this mirrors the way things are
>>>> handled for the axp202 pmic.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>   arch/arm/boot/dts/axp152.dtsi | 49 +++++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 49 insertions(+)
>>>>   create mode 100644 arch/arm/boot/dts/axp152.dtsi
>>>
>>> Unfortunately, Mark expressed clearly that he didn't want such files.
>>
>> That is not how I remember the discussion, he said that he did not consider
>> them useful, we explained why we do consider them useful for the sunxi
>> case and then things went quiet.
>>
>> And we do already have an axp209.dtsi, and I find having that useful
>> for enabling the regulators on axp209 using boards.
>
> Hmmm, reading this discussion again, it indeed looks like I
> misremembered what he was saying.
>
>> Ultimately it is your call, but I really think we should be consistent
>> and add an axp152.dtsi to mirror how we do things with the axp209.
>
> Was there any other comments on this serie (and are you going to send
> a v2?) or should I apply this patch?

There were some comments on the actual mfd bits of this series, and
I will send a v2 for that sometime this week. The dts patches however
are good to go, so please apply this one.

Regards,

Hans
