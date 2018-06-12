From: leoyang.li@nxp.com (Li Yang)
Date: Tue, 12 Jun 2018 13:50:04 -0500
Subject: [PATCH] arm64: dts: freescale: Update to use SPDX identifiers
In-Reply-To: <CAOMZO5C0pk-27ztxeJSENBN_-i9o+2sCoS9Cc75Q_Y=-_z_dQg@mail.gmail.com>
References: <1528828122-9276-1-git-send-email-leoyang.li@nxp.com>
 <CAOMZO5C0pk-27ztxeJSENBN_-i9o+2sCoS9Cc75Q_Y=-_z_dQg@mail.gmail.com>
Message-ID: <CADRPPNQCJ32KOvaO1RRPkxjep9WbXRVZm5CsdLB0k+6p4qRr+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 1:32 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Li,
>
> On Tue, Jun 12, 2018 at 3:28 PM, Li Yang <leoyang.li@nxp.com> wrote:
>
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>> index 7286b1e..f90c040 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>> @@ -1,45 +1,9 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> Here you use GPL-2.0+
>
>>  /*
>>   * Device Tree file for Freescale LS1012A Freedom Board.
>>   *
>>   * Copyright 2016 Freescale Semiconductor, Inc.
>>   *
>> - * This file is dual-licensed: you can use it either under the terms
>> - * of the GPLv2 or the X11 license, at your option. Note that this dual
>
> ,but the original text says  GPL-2.0, not  GPL-2.0+, so there is a mismatch.

The original text has a conflict probably because some people didn't
regard GPLv2+ as a license name.  But the following detailed
explanation mentioned "you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation;either version 2 of the License, or (at your
option) any later version."  I think we should honor the more verbosed
text than the briefing(same way for X11 vs MIT).

Regards,
Leo
