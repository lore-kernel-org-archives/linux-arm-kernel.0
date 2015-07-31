From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Jul 2015 18:27:25 +0800
Subject: [PATCH 0/3] ARM: dts: sun5i: hsg-h702: Enable USB OTG and LRADC
 keys
In-Reply-To: <CAGb2v67inrVy844RjeBUBKOwPBPZfZQ-2OQmkMbDGURvbP4JqQ@mail.gmail.com>
References: <1438337501-8773-1-git-send-email-wens@csie.org>
 <CAGb2v67inrVy844RjeBUBKOwPBPZfZQ-2OQmkMbDGURvbP4JqQ@mail.gmail.com>
Message-ID: <CAGb2v64BK=jC=qTzTA-BS3uiy0oCWdBn8n4+EqeOpk_zML5o9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 6:12 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Fri, Jul 31, 2015 at 6:11 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> Hi Maxime,
>>
>> This series enables USB OTG and the volume buttons on the side of
>> the HSG-H702 tablet.
>
> Sorry, please ignore. Something bad happened when I split the patches.

PEBCAK .. The series doesn't compile because of the last patch.

Anyway, since you had some comments on the patches Hans posted, I'll
fix up the same issues in mine as well.

ChenYu

>> The third patch is just for reference, as the axp209 usb power supply
>> driver hasn't been merged yet.
>>
>>
>> Regards
>> ChenYu
>>
>>
>> Chen-Yu Tsai (3):
>>   ARM: dts: sun5i: hsg-h702: Enable side volume buttons with LRADC
>>   ARM: dts: sun5i: hsg-h702: Enable USB OTG controller
>>   ARM: dts: sun5i: hsg-h702: Enable AXP209 USB power supply
>>
>>  arch/arm/boot/dts/sun5i-a13-hsg-h702.dts | 65 ++++++++++++++++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>
>> --
>> 2.5.0
>>
