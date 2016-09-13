From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 13 Sep 2016 11:06:02 +0200
Subject: [PATCH V4 3/4] ARM: bcm2835: add thermal node to device-tree of
 bcm283x
In-Reply-To: <677965855.33392.597ccfbe-225b-403b-8ffa-3f42292996d4.open-xchange@email.1und1.de>
References: <1473407397-29395-1-git-send-email-kernel@martin.sperl.org>
 <1473407397-29395-4-git-send-email-kernel@martin.sperl.org>
 <19cc8fbf-6ceb-995e-850d-9d82bdaff8d0@i2se.com>
 <8876586A-98F8-4AAF-AD90-86EB12C22FDC@martin.sperl.org>
 <2117811305.32861.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange@email.1und1.de>
 <185DA6B2-AFC0-4199-A361-0164381AD317@martin.sperl.org>
 <677965855.33392.597ccfbe-225b-403b-8ffa-3f42292996d4.open-xchange@email.1und1.de>
Message-ID: <704dd583-5bd8-fa77-a4ab-18f0845b9c4e@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09.09.2016 21:02, Stefan Wahren wrote:
> bcm2837.dtsi
>
> &thermal {
>             compatible = "brcm,bcm2837-thermal";
>             status = "okay";
> };

Note that there is only a bcm2837.dtsi in arm64/boot/dts/broadcom/
but not in arm/boot/dts - at least with the current upstream kernel.

So I will just patch those dtsi that exist right now.

Martin
