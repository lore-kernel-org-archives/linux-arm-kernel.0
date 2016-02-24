From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 24 Feb 2016 14:26:37 +0100
Subject: [linux-sunxi] [PATCH 2/2] ARM: dts: sun8i: Enable ir receiver on
 orangepi pc
In-Reply-To: <20160224121640.GA25658@box2.japko.eu>
References: <1456268597-13692-1-git-send-email-hdegoede@redhat.com>
 <1456268597-13692-3-git-send-email-hdegoede@redhat.com>
 <20160224121640.GA25658@box2.japko.eu>
Message-ID: <56CDAF8D.70501@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24-02-16 13:16, Krzysztof Adamski wrote:
> On Wed, Feb 24, 2016 at 12:03:17AM +0100, Hans de Goede wrote:
>> Enable the ir receiver found on the orangepi pc board.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>
> I don't think this file is avaiable in mainline. Wouldn't it be better to use patch against existing orangepi-plus dts file?
>
> Otherwise I tested this patch and it works fine on my Orangepi PC (some data is splitted out when reading /dev/input/event0).

Ah yes, that is my bad, I've been waiting with upstreaming an orangepi-pc dts until all the
usb bits are upstream as my dts has usb host support enabled, I should probably split
out the usb-host support and upstream the rest already.

Regards,

Hans
