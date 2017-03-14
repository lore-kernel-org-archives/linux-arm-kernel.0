From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 14 Mar 2017 19:10:29 +0100
Subject: [PATCH 1/4] ARM64: Prepare Marvell IAP140 aka PXA1908
In-Reply-To: <CAPDyKFoy-dKTk=t6cmwzbjyntZHrkSyZbtpJ0wAMUDJ5xz4viA@mail.gmail.com>
References: <20170219032000.4674-1-afaerber@suse.de>
 <20170219032000.4674-2-afaerber@suse.de>
 <CAPDyKFoy-dKTk=t6cmwzbjyntZHrkSyZbtpJ0wAMUDJ5xz4viA@mail.gmail.com>
Message-ID: <9c1fe53f-d25a-6bba-c324-a08818431795@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.03.2017 um 17:30 schrieb Ulf Hansson:
> On 19 February 2017 at 04:19, Andreas F?rber <afaerber@suse.de> wrote:
>> Suppress COMMON_CLK_PXA and MMC_PXA for now as they don't build on arm64.
>> Also suppress the deprecated SERIAL_PXA in favor of SERIAL_8250_PXA.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  arch/arm64/Kconfig.platforms | 5 +++++
>>  drivers/clk/Kconfig          | 2 +-
>>  drivers/mmc/host/Kconfig     | 2 +-
>>  drivers/tty/serial/Kconfig   | 2 +-
>>  4 files changed, 8 insertions(+), 3 deletions(-)
> 
> Please try split this up so it can be applied on each subsystem independently.

I believe that comment is obsoleted by later versions of the patchset
using ARCH_MMP instead?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
