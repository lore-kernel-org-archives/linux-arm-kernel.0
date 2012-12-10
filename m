From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Dec 2012 15:01:01 +0100
Subject: [PATCH 0/2] add RTC support for Armada 370 and Armada XP
In-Reply-To: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
References: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121210150101.4efe862a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Mon, 10 Dec 2012 11:42:00 +0100, Gregory CLEMENT wrote:

> This small patchset adds RTC support for Armada 370 and Armada XP. It
> was succesfully tested on the evaluation board. The second patch add
> the lacking documentation for the device tree binding. This serie is
> 3.9 material.
> 
> Thanks,
> 
> 
> Gregory CLEMENT (2):
>   arm: mvebu: add RTC support for Armada 370 and Armada XP
>   rtc: rtc-mv: Add the device tree binding documentation

Would you mind adding a patch that updates the mvebu_defconfig to
include the RTC driver by default?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
