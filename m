From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Wed, 7 Jun 2017 07:16:05 +0000
Subject: [PATCH 0/3] Add stm32h743i-disco board
In-Reply-To: <f8d09cbf-8535-5906-28ee-6d9774a49c44@st.com>
References: <1496765613-697-1-git-send-email-patrice.chotard@st.com>
 <f8d09cbf-8535-5906-28ee-6d9774a49c44@st.com>
Message-ID: <a9ad0792-8900-638e-e53e-4a7708c30ad2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex

On 06/07/2017 09:04 AM, Alexandre Torgue wrote:
> Hi Patrice
> 
> On 06/06/2017 06:13 PM, patrice.chotard at st.com wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> This series adds basic support for the stm32h743i discovery board
>> based on stm32h7 MCU.
>>
>> Patrice Chotard (3):
>>   ARM: dts: stm32h743: Add usart2_pins
>>   ARM: dts: stm32h743: Add usart2 support
>>   ARM: dts: stm32h743: Add stm32h743i-disco board
>>
>>  arch/arm/boot/dts/Makefile               |  3 +-
>>  arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 13 ++++++
>>  arch/arm/boot/dts/stm32h743.dtsi         |  8 ++++
>>  arch/arm/boot/dts/stm32h743i-disco.dts   | 74 
>> ++++++++++++++++++++++++++++++++
>>  4 files changed, 97 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/stm32h743i-disco.dts
>>
> 
> Series looks fine for me, but can you change commit header please. For 
> example: ARM: dts: stm32: Add usart2_pins on stm32h743.
> 
> Soon it will be done, I will apply it for next pull request.

Sure, the v2 is on the way

Patrice

> 
> Regards
> Alex
