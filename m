From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 27 Oct 2012 18:35:33 +0200
Subject: [PATCH] arm: mvebu: support for the Globalscale Mirabox MBX0001
 board
In-Reply-To: <20121027183326.62ab505a@skate>
References: <1351354965-23875-1-git-send-email-gregory.clement@free-electrons.com>
 <20121027183326.62ab505a@skate>
Message-ID: <508C0D55.30205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2012 06:33 PM, Thomas Petazzoni wrote:
> On Sat, 27 Oct 2012 18:22:45 +0200, Gregory CLEMENT wrote:
>> This platform, available from Globalscale has an Armada 370. For now,
>> only the serial port is supported. Support for network, USB and other
>> peripherals will be added as drivers for them become available for
>> Armada 370 in mainline.
>
> Great!

ACK!

>> +++ b/arch/arm/boot/dts/mbx001.dts
>
> If you decided to name your platform with four zeros (00001), then the
> file should be mbx0001.dts here.

What is wrong with "globalscale,mirabox" ?

Sebastian
