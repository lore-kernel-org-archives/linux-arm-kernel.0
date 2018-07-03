From: faiz_abbas@ti.com (Faiz Abbas)
Date: Tue, 3 Jul 2018 12:01:17 +0530
Subject: [PATCH] ARM: dts: am335x-bone-common: Fix mmc0 Write Protect
In-Reply-To: <20180703062419.GB112168@atomide.com>
References: <20180702202143.25343-1-robertcnelson@gmail.com>
 <20180703062419.GB112168@atomide.com>
Message-ID: <6c0eb111-a301-d6c9-46c9-7bc45c82511c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 03 July 2018 11:54 AM, Tony Lindgren wrote:
> * Robert Nelson <robertcnelson@gmail.com> [180702 20:24]:
>> Mainline Commit b74c2b21e1551018af53ee6c1efc051dfce2d788 added the pinmux
>> settings for mmc1, however this pin (0x9a0) is routed to P9_42 on the cape
>> header. Thus any BeagleBone cape that utilizes P9_42 triggers mmc0's Write
>> Protect.
> 
> Thanks applying into omap-for-v4.18/fixes. I'll also add a Fixes tag for
> it.
> 

The evm sk sdwp needs to be removed as well. I guess I'll post a
separate patch as this is already applied.

Thanks,
Faiz
