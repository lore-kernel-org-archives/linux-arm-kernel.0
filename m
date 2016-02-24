From: k@japko.eu (Krzysztof Adamski)
Date: Wed, 24 Feb 2016 13:16:41 +0100
Subject: [linux-sunxi] [PATCH 2/2] ARM: dts: sun8i: Enable ir receiver on
 orangepi pc
In-Reply-To: <1456268597-13692-3-git-send-email-hdegoede@redhat.com>
References: <1456268597-13692-1-git-send-email-hdegoede@redhat.com>
 <1456268597-13692-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20160224121640.GA25658@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 12:03:17AM +0100, Hans de Goede wrote:
>Enable the ir receiver found on the orangepi pc board.
>
>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>---
> arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts

I don't think this file is avaiable in mainline. Wouldn't it be better 
to use patch against existing orangepi-plus dts file?

Otherwise I tested this patch and it works fine on my Orangepi PC (some 
data is splitted out when reading /dev/input/event0).

Best regards,
Krzysztof Adamski
