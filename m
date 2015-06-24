From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 24 Jun 2015 21:47:51 +0200
Subject: [PATCH v2 2/2] arm64: dts: mt8173: Add I2C device node
In-Reply-To: <CAGS+omC0n1eADRCy58a4C=w9LikPvQv=bHopNTE1XXW3h7zRLA@mail.gmail.com>
References: <1433164107-26568-1-git-send-email-eddie.huang@mediatek.com>
 <1433164107-26568-3-git-send-email-eddie.huang@mediatek.com>
 <5279457.I1q8kC8mJN@ubix>
 <CAGS+omC0n1eADRCy58a4C=w9LikPvQv=bHopNTE1XXW3h7zRLA@mail.gmail.com>
Message-ID: <CABuKBeJesxK2_tFwxkbFi8w2Tb3p=RQpehLp2nNmM_VWz-rOGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-24 13:00 GMT+02:00 Daniel Kurtz <djkurtz@chromium.org>:
> Hi Matthias,
>
> On Wed, Jun 24, 2015 at 4:04 AM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>> On Monday, June 01, 2015 09:08:27 PM Eddie Huang wrote:
>>> Add MT8173 I2C device nodes, include I2C controllers and pins.
>>> MT8173 has six I2C controllers, from i2c0 to i2c6, exclude i2c5.
>>> The 6th I2C controller register base doesn't next to 5th I2C,
>>> and there is a hardware between 5th and 6th I2C controller. So
>>> SoC designer name 6th controller as "i2c6", not "i2c5".
>>>
>>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>>> ---
>>
>> applied to v4.2-next/arm64
>
> It looks like [0] has the pinctrl changes, but lost the actual i2c nodes.

Huh, thanks for noting that. I just fixed it.

Regards,
Matthias
