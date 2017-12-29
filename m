From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 29 Dec 2017 16:56:16 +0800
Subject: [linux-sunxi] [PATCH] ARM: dts: sun8i: fix USB Ethernet of Orange
 Pi R1
In-Reply-To: <CAGb2v679BdkA=4hzsTiHXwqdSop+dFDTePqmd_eNSMQR+gq9fg@mail.gmail.com>
References: <20171228140538.14388-1-icenowy@aosc.io>
 <CAGb2v679BdkA=4hzsTiHXwqdSop+dFDTePqmd_eNSMQR+gq9fg@mail.gmail.com>
Message-ID: <511FDCF7-4B8D-4270-8E51-FF723AF07082@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?12?29? GMT+08:00 ??4:55:34, Chen-Yu Tsai <wens@csie.org> ??:
>On Thu, Dec 28, 2017 at 10:05 PM, Icenowy Zheng <icenowy@aosc.io>
>wrote:
>> Orange Pi R1 uses a Realtek RTL8152B USB Ethernet chip, which is
>easily
>> seen on the board but not show in the schematics. A regulator for the
>> power of the RTL8152B chip is hidden, which uses the same pin with
>the
>> Wi-Fi regulator on the original Orange Pi Zero.
>>
>> Add this regulator back to the device tree, and bind it to USB1.
>>
>> Tested-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
>Applied. There is no guarantee this will make it into 4.16-rc1. If not,
>this will be sent later on as a fix for 4.16.

Because of New Year?

>
>ChenYu
