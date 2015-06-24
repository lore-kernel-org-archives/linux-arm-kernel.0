From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 24 Jun 2015 19:00:42 +0800
Subject: [PATCH v2 2/2] arm64: dts: mt8173: Add I2C device node
In-Reply-To: <5279457.I1q8kC8mJN@ubix>
References: <1433164107-26568-1-git-send-email-eddie.huang@mediatek.com>
 <1433164107-26568-3-git-send-email-eddie.huang@mediatek.com>
 <5279457.I1q8kC8mJN@ubix>
Message-ID: <CAGS+omC0n1eADRCy58a4C=w9LikPvQv=bHopNTE1XXW3h7zRLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Wed, Jun 24, 2015 at 4:04 AM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> On Monday, June 01, 2015 09:08:27 PM Eddie Huang wrote:
>> Add MT8173 I2C device nodes, include I2C controllers and pins.
>> MT8173 has six I2C controllers, from i2c0 to i2c6, exclude i2c5.
>> The 6th I2C controller register base doesn't next to 5th I2C,
>> and there is a hardware between 5th and 6th I2C controller. So
>> SoC designer name 6th controller as "i2c6", not "i2c5".
>>
>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>> ---
>
> applied to v4.2-next/arm64

It looks like [0] has the pinctrl changes, but lost the actual i2c nodes.

[0] https://github.com/mbgg/linux-mediatek/commit/0afbf26eda52831560e9f60427751ab8b2641eef

Thanks,
-Dan

>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
