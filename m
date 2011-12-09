From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Dec 2011 14:23:12 +0000
Subject: [GIT PULL] pxa changes for v3.3
In-Reply-To: <CAN1soZz3LcnoFUmFR8go5_ga0-tT9rnxDwtVz9j-P=Ef2Lkp4w@mail.gmail.com>
References: <CAN1soZz3LcnoFUmFR8go5_ga0-tT9rnxDwtVz9j-P=Ef2Lkp4w@mail.gmail.com>
Message-ID: <201112091423.12990.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 December 2011, Haojian Zhuang wrote:
> Please pull these for v3.3.
> 
> The four patches in below are used to fix build issue while gpio-pxa
> is changed to platform driver.
>       pcmcia: pxa: replace IRQ_GPIO() with gpio_to_irq()
>       Input: zylonite-wm97xx - replace IRQ_GPIO() with gpio_to_irq()
>       ARM: pxa: fix build error for GPIO_bit()
>       ARM: pxa: fix the build error because of missing gpio-pxa.h
> 
> 
> The following changes since commit 1fc27d6c81c881a67fcd1ff983f23c06cdd2a93f:
> 
>   Merge branch 'fixes' into for-next (2011-12-06 14:24:24 +0000)
> 
> are available in the git repository at:
> 
>   git://github.com/hzhuang1/linux.git for-next
> 

Sorry, I can't pull these. As I explained to other people before, you cannot
base your submissions on the for-next branch because that is not kept stable.

The patches in here all look ok, so just rebase these onto 3.2-rc4.
Also, please keep the bug fixes separate from features so I can send
the fixes early (ideally for 3.2) while I queue up the other patches
for 3.3. See my "subarch maintainers: please send 3.3 pull requests for
arm-soc" for the other instructions.

	Arnd
