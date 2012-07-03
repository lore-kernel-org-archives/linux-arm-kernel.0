From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarh)
Date: Tue, 03 Jul 2012 15:03:44 +0200
Subject: [PATCH 0/3] ARM: dts: dove: Basic devicetree support for Marvell
 Dove
In-Reply-To: <20120703125017.GB17534@lunn.ch>
References: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
 <20120703125017.GB17534@lunn.ch>
Message-ID: <4FF2EDB0.3040707@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2012 02:50 PM, Andrew Lunn wrote:
>>   create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
>>   create mode 100644 arch/arm/boot/dts/dove-dove-db.dtsi
>
> These two should be dts files, not dtsi. They are not include files.

Ok, I will move them to .dts files for v2 of the patches

> I also noticed a few mrvl in the compatibility strings. We have
> decided to use marvell.

I am fine with 'marvell' instead of 'mrvl'. But the name change
has not been commited to arm-soc, yet? I can create a patch to
rename all occurrences of mrvl to marvell if you like.

Sebastian
