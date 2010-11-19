From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 19 Nov 2010 20:11:59 +0300
Subject: [PATCH v6 11/12] davinci: add tnetv107x evm backlight device
In-Reply-To: <4CE6AE19.6090600@ti.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-12-git-send-email-cyril@ti.com>
	<4CE6A950.8040704@mvista.com> <4CE6AE19.6090600@ti.com>
Message-ID: <4CE6AFDF.3080709@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Cyril Chemparathy wrote:

>>> The tnetv107x evm board has a backlight device that is connected on one of the
>>> SSP ports.  This patch adds the board definitions necessary to plug the
>>> backlight driver to the GPIO corresponding to this SSP pin.
>>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>>> ---
>>>  arch/arm/mach-davinci/board-tnetv107x-evm.c |   14 ++++++++++++++
>>>  1 files changed, 14 insertions(+), 0 deletions(-)
>>> diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
>>> index e3863dd..ac62de2 100644
>>> --- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
>>> +++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
>>> @@ -44,6 +44,7 @@
>>>  #define EVM_MMC_WP_GPIO		21
>>>  #define EVM_MMC_CD_GPIO		24
>>>  #define EVM_SPI_CS_GPIO		54
>>> +#define EVM_BACKLIGHT_GPIO	(SSP_GPIO_START + 2)

>>     Why it's not aligned with others?

> It actually is aligned if you remove the leading space/+.

    Heh, realized that after sending. :-)
    That's why I use spaces instead of one-space tab. Unfortunately, 
scripts/checkpatch.pl does not like it now... :-/

> Regards
> Cyril.

WBR, Sergei
