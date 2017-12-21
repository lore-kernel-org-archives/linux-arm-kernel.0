From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 21:48:33 +0100
Subject: [PATCH V2 3/9] ARM: stm32: prepare stm32 family to welcome armv7
 architecture
In-Reply-To: <4093a02c-3216-d668-a6d8-1ce76046b554@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
 <1513610272-7824-4-git-send-email-ludovic.Barre@st.com>
 <CAK8P3a1WzkVQ3591XjVQPLCqP0_zZ4ksqJqWvm7de_OnkE3oaQ@mail.gmail.com>
 <8092d8f9-c097-136f-4f6f-0b7ffea17c91@st.com>
 <4093a02c-3216-d668-a6d8-1ce76046b554@st.com>
Message-ID: <CAK8P3a0ckEZednkP1XttxMDFT7ZEYuyp-QtuhUgJ0jAtp9cXZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 5:39 PM, Ludovic BARRE <ludovic.barre@st.com> wrote:

>>>
>> Currently "restart" is not functional on stm32 MCU (at least for
>> stm32f746, I will check on others MCU). My fear is if Ludovic made some
>> patches to make "armv7m_restart" the default ".restart" function for all
>> armv7-m platform, he will not be able to test it on stm32 MCU (as it is not
>> currently working). I propose to do it in 2 steps:
>>
>> 1-Keep as you suggest only one board-dt.c file for both (MCU and MPU) and
>> remove ".restart" function.
>>
>> 2-Investigate and send patches around ".restart" for both in an other
>> series.
>
>
> I resend

Yes, that seems fine.

       Arnd
