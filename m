From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 19 May 2014 19:45:08 +0200
Subject: [RFC PATCH 1/3] mfd: AXP22x: add support for APX221 PMIC
In-Reply-To: <20140519172817.GE20435@lee--X1>
References: <1400176305-22737-1-git-send-email-boris.brezillon@free-electrons.com>
 <1400176305-22737-2-git-send-email-boris.brezillon@free-electrons.com>
 <20140519172817.GE20435@lee--X1>
Message-ID: <537A4324.4060905@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On 19/05/2014 19:28, Lee Jones wrote:
>> This patch introduces preliminary support for the X-Powers AXP221 PMIC.
>> The AXP221 is typically used on boards using Allwinner's A31 SoC.
>>
>> At the moment, this driver only exposes regulator devices, but other
>> subdevices.
>>
>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> ---
>>  drivers/mfd/Kconfig        |  12 +++
>>  drivers/mfd/Makefile       |   1 +
>>  drivers/mfd/axp22x.c       | 237 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/axp22x.h | 149 ++++++++++++++++++++++++++++
>>  4 files changed, 399 insertions(+)
>>  create mode 100644 drivers/mfd/axp22x.c
>>  create mode 100644 include/linux/mfd/axp22x.h
> Not a chance.
>
> Farrrr, too much common code with axp20x.c - please merge into one file.
>

This was one of the questions I asked in my cover letter (could you take
a look at it and tell me what's your prefered solution ?) ;-).

I first tried to reuse the axp20x drivers, but ended up copying almost
all definitions, hence I decided to first do a different driver and ask
for advices.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
