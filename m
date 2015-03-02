From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 2 Mar 2015 17:32:02 +0800
Subject: [PATCH v2 0/2] ARM: at91: dt: at91sam9n12ek: enable udp device
In-Reply-To: <1423533335-25135-1-git-send-email-voice.shen@atmel.com>
References: <1423533335-25135-1-git-send-email-voice.shen@atmel.com>
Message-ID: <54F42E12.4010808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On 02/10/2015 09:55 AM, Bo Shen wrote:
> This patch series enable usb device support on at91sam9n12ek board.
>
> Changes in v2:
>    - Base on next-20150209 (so, remove the modification of udc driver).
>    - Add pinctrl for usb1 vbus sense.
>
> Bo Shen (2):
>    ARM: at91: dt: at91sam9n12: add udp device node
>    ARM: at91: dt: at91sam9n12ek: enable udp

Any comments for this patch series? (aka ping?)

>   arch/arm/boot/dts/at91sam9n12.dtsi  |  9 +++++++++
>   arch/arm/boot/dts/at91sam9n12ek.dts | 14 ++++++++++++++
>   2 files changed, 23 insertions(+)
>

Best Regards,
Bo Shen
