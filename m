From: eric@anholt.net (Eric Anholt)
Date: Tue, 08 Mar 2016 10:04:35 -0800
Subject: [PATCH 3/3] ARM: bcm2835: Add VC4 to the device tree.
In-Reply-To: <56DE6A80.1060707@wwwdotorg.org>
References: <1457123528-13482-1-git-send-email-eric@anholt.net>
 <1457123528-13482-4-git-send-email-eric@anholt.net>
 <56DE6A80.1060707@wwwdotorg.org>
Message-ID: <87bn6ozw0c.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 03/04/2016 01:32 PM, Eric Anholt wrote:
>> VC4 is the GPU (display and 3D) present on the 283x.
>
>> diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
>
>> +&hdmi {
>> +	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
>> +};
>
> Isn't that the same everywhere? If so, adding it to bcm2835-rpi.dtsi 
> seems like a better idea; it'd avoid duplicating it everywhere.

It's not the same everywhere (_HIGH vs _LOW), which is why it's in the
individual files.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160308/1566a353/attachment.sig>
