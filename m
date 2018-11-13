From: bich.hemon@st.com (Bich HEMON)
Date: Tue, 13 Nov 2018 09:16:16 +0000
Subject: [PATCH] ARM: stm32: debug: add low-level debug support
In-Reply-To: <20181112182236.s7cs6dol4dmxkp7u@localhost>
References: <1501174209-27550-1-git-send-email-bich.hemon@st.com>
 <1501174209-27550-2-git-send-email-bich.hemon@st.com>
 <20181112182236.s7cs6dol4dmxkp7u@localhost>
Message-ID: <f244c67b-de86-b0e7-7283-7b27f9591cf9@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/12/18 7:22 PM, Olof Johansson wrote:
> On Thu, Jul 27, 2017 at 04:50:20PM +0000, Bich HEMON wrote:
>> From: Gerald Baeza <gerald.baeza@st.com>
>>
>> This adds low-level debug support on USART1 for STM32F4
>> and STM32F7.
>> Compiled via 'CONFIG_DEBUG_LL' and 'CONFIG_EARLY_PRINTK'.
>> Enabled via 'earlyprintk' in bootargs.
>>
>> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
>> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> 
> Hi,
> 
> This had fallen between the chairs it seems. I have applied it to arm-soc
> next/soc now, for 4.21 merge window.
> 
> It ended up being patched up manually to consolidate the version in
> Russell's patch tracker with this posted version, and I tweaked whitespace
> a bit. Let me know if I missed something.
> 
> 
> Thanks,
> 
> -Olof
> 

Hi Olof,

Please note that this patch has to be abandoned as Ludovic BARRE pushed 
a new version of this change:
https://patchwork.codeaurora.org/patch/400563/

You can find it in Russell's tracker here:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8803/1

Best regards,

Bich
