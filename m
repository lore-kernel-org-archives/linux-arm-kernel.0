From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 2 Mar 2011 11:08:30 +0800
Subject: [PATCH 2/6] ARM: pxa2xx: reorganize I2C files
In-Reply-To: <4D6D9426.8030905@fluff.org>
References: <1298461100-14869-1-git-send-email-bigeasy@linutronix.de>
	<1298461100-14869-3-git-send-email-bigeasy@linutronix.de>
	<4D6D9426.8030905@fluff.org>
Message-ID: <AANLkTikPDAtH10gPauq9F54MFSg=XBKt-p-PVXp8J7AW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2011 at 8:49 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On 23/02/11 11:38, Sebastian Andrzej Siewior wrote:
>>
>> This patch moves the platform data definition from
>> arch/arm/plat-pxa/include/plat/i2c.h to include/linux/i2c/pxa-i2c.h so
>> it can be accessed from x86 the same way as on ARM.
>>
>> This change should make no functional change to the PXA code. The move
>> is verified by building the following defconfigs:
>> ? cm_x2xx_defconfig corgi_defconfig em_x270_defconfig ezx_defconfig
>> ? imote2_defconfig pxa3xx_defconfig spitz_defconfig zeus_defconfig
>> ? raumfeld_defconfig magician_defconfig mmp2_defconfig pxa168_defconfig
>> ? pxa910_defconfig
>>
>
> Russell/others, you OK with this going through my tree?
>

Ben, I'm fine that you take this change. Trivial changes to me, so
I expect no significant merge conflicts.
