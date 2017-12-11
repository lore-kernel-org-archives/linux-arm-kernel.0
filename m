From: ludovic.barre@st.com (Ludovic BARRE)
Date: Mon, 11 Dec 2017 11:22:07 +0100
Subject: [PATCH] ARM: debug: add stm32 low-level debug support
In-Reply-To: <CAOFm3uHzot+BAxKr2o72bc3jknZ_buxU=iG08QTLvG60yUzTWg@mail.gmail.com>
References: <1512394376-25962-1-git-send-email-ludovic.Barre@st.com>
 <edcc6666-31eb-5404-0a3e-fa6051707408@st.com>
 <CAOFm3uHzot+BAxKr2o72bc3jknZ_buxU=iG08QTLvG60yUzTWg@mail.gmail.com>
Message-ID: <fd856ee5-9421-a832-85fe-8b4af604fbbf@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil, Philippe

thanks for review

I will send V2 with:
-my "signed-off"
-Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
-SPDX license
/* SPDX-License-Identifier: GPL-2.0 */

BR
Ludo

On 12/11/2017 10:33 AM, Philippe Ombredanne wrote:
> Ludovic,
> 
> On Mon, Dec 11, 2017 at 10:08 AM, Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>> Hi Ludovic
>>
>> On 12/04/2017 02:32 PM, Ludovic Barre wrote:
>>>
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> This adds low-level debug support on USART1 for STM32F4
>>> and STM32F7. Compiled via 'CONFIG_DEBUG_LL' and 'CONFIG_EARLY_PRINTK'.
>>> Enabled via 'earlyprintk' in bootargs.
>>>
>>> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
>>
>>
>> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
> 
> [...]
> 
>>> --- /dev/null
>>> +++ b/arch/arm/include/debug/stm32.S
>>> @@ -0,0 +1,41 @@
>>> +/*
>>> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>>> + * Author: Gerald Baeza <gerald_baeza@st.com>
>>> + * License terms:  GNU General Public License (GPL), version 2
> 
> Have you considered using the new SPDX ids? See THomas doc patches for details.
> 
