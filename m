From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 7 Dec 2017 22:19:33 +0100
Subject: [PATCH v8 1/3] arm: npcm: add basic support for Nuvoton BMCs
In-Reply-To: <CAFd5g45+dNuayw=s08iwAj2wrUYNXnGd5SbA+OVvsL_J6APHGA@mail.gmail.com>
References: <20171117190747.21642-1-brendanhiggins@google.com>
 <20171117190747.21642-2-brendanhiggins@google.com>
 <CAFd5g45+dNuayw=s08iwAj2wrUYNXnGd5SbA+OVvsL_J6APHGA@mail.gmail.com>
Message-ID: <CAOFm3uG=i3gOnKEMEPNii070+pB7Aqt2GmxgB5G0DCfGzhCkZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brendan,

On Thu, Dec 7, 2017 at 9:37 PM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> Any update on this?
>
> On Fri, Nov 17, 2017 at 11:07 AM, Brendan Higgins
> <brendanhiggins@google.com> wrote:
>> Adds basic support for the Nuvoton NPCM750 BMC.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
>> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
>> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
>> Tested-by: Avi Fishman <avifishman70@gmail.com>

<snip>

>> --- /dev/null
>> +++ b/arch/arm/mach-npcm/npcm7xx.c
>> @@ -0,0 +1,25 @@
>> +/*
>> + * Copyright (c) 2017 Nuvoton Technology corporation.
>> + * Copyright 2017 Google, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */

Have you considered using the new SPDX ids here instead of the
traditional license boilerplate?

This could come out this way:

// SPDX-License-Identifier: GPL-2.0
// Copyright (c) 2017 Nuvoton Technology corporation.
// Copyright 2017 Google, Inc.

It is shorter and simpler, with a better code/comments ratio.
And if you wonder about why using C++ style comment, please check
Linus posts on the topic, as well as Thomas doc patches.

Thank you for your kind consideration!

-- 
Cordially
Philippe Ombredanne
