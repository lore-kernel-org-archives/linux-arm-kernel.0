From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Sun, 17 Dec 2017 23:55:36 +0100
Subject: [PATCH v2 9/9] ARM: dts: imx7: add Toradex Colibri iMX7D 1GB
 (eMMC) support
In-Reply-To: <CAOMZO5BXEj9AKeQEVNhDYMCydpe+PVnXjchvTAuuwdM7Yp6d2w@mail.gmail.com>
References: <20171217203723.15896-1-stefan@agner.ch>
 <20171217203723.15896-9-stefan@agner.ch>
 <CAOMZO5BXEj9AKeQEVNhDYMCydpe+PVnXjchvTAuuwdM7Yp6d2w@mail.gmail.com>
Message-ID: <CAOFm3uHFcHnh-CHLfJwgeB1M8niWBtdpVv-f+Dr7b43f70zwbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio,

On Sun, Dec 17, 2017 at 10:59 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Stefan,
>
> On Sun, Dec 17, 2017 at 6:37 PM, Stefan Agner <stefan@agner.ch> wrote:
>
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
>> @@ -0,0 +1,20 @@
>> +/*
>> + * Copyright 2017 Toradex AG
>> + *
>> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> + */
>
> In the previous patch you used GPL-2.0 text, instead of GPL-2.0+.
>
> The SPDX line should be the first one and start with a // style comment:
>
> // SPDX-License-Identifier: (GPL-2.0 OR MIT)

Yes this line as the top line is the correct way as explained in
Thomas doc patches [1]
I cannot comment of whether the author wants GPL 2 or 2+ though KISS is best.

[1] https://lkml.org/lkml/2017/12/4/934

> Philippe, please confirm this is the correct way.
>
> With this fixed you can add:
>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

-- 
Cordially
Philippe Ombredanne
