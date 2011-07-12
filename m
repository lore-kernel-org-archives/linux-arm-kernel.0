From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 12 Jul 2011 16:39:47 -0500
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace boot_params
In-Reply-To: <20110712204814.GD15997@ibawizard.net>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<20110708203634.GU4812@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107081714251.14596@xanadu.home>
	<alpine.LFD.2.00.1107111046350.14596@xanadu.home>
	<ADE657CA350FB648AAC2C43247A983F001F383D6D6F7@AUSP01VMBX24.collaborationhost.net>
	<20110712204814.GD15997@ibawizard.net>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383E054DE@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 12, 2011 1:48 PM, Petr ?tetiar wrote:
> H Hartley Sweeten <hartleys@visionengravers.com> [2011-07-11 12:17:25]:
>
>> Unfortunately, all the ep93xx boards I have are designed with the sdram using
>> nSDCS0 so I can't test the other boot configurations.
>
> I've tested that actual patchset from nico/redux git branch[1,2] on
> ts-7250/32M and ts-7300/128M (both nSDCS3) and it boots, so you can add my
> tested-by if you like:
> 
> Tested-by: Petr ?tetiar <ynezz@true.cz>
> 
> 1. git://git.linaro.org/people/nico/linux.git redux
> 2. git hash bc869e434e411ee7f3fcfed7594ee64b1d56b3c9

So, I guess the big test would be to see if a kernel that boots on your boards
using nSDCS3 will also boot on mine using nSDCS0.

Could you rebuild your kernel with MACH_EDB9307A also selected in your
config?  After verifying that it still boots please either send me the zImage
or place it somewhere I can grab it and I will make sure it boots on mine.

Regards,
Hartley
