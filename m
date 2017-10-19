From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Oct 2017 00:32:30 +0200
Subject: [GIT PULL] STM32 DT changes for v4.15 #1
In-Reply-To: <CAK8P3a1ZJeBZ3f0xJ3htYxr7jq2xRkt0Fd=rMhbdia03tXHVBA@mail.gmail.com>
References: <9a7b3184-0bc0-3f81-78ef-057fa4541530@st.com>
 <CAK8P3a1ZJeBZ3f0xJ3htYxr7jq2xRkt0Fd=rMhbdia03tXHVBA@mail.gmail.com>
Message-ID: <CAK8P3a0s=KFGnySesFDp9tuEr1X5VMW06mrA6oKrj-8Ts+P5mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 12:31 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Oct 17, 2017 at 12:21 PM, Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>
>> ----------------------------------------------------------------
>> STM32 DT updates for v4.15, round 1
>>
>> Highlights:
>> ----------
>>  -Add I2C1 support on STM32F746 SoC
>>  -Enable I2C1 on STM32F746 eval board
>>  -Add Timers support on STM32F746 SoC
>>  -Add USB HS and FS supports on STM32F746 Soc
>>  -Enable USB HS on STM32F746 disco and eval boards
>>  -Enable USB FS en STM32F746 disco board
>>  -Add Vrefbuf to STM32H743 SoC
>>  -Add LPTIMERS support on STM32H743 SoC
>>  -Add DMAMUX support on STM32H743 SoC
>>  -Enable STM32H743 clock driver
>>  -Add MDMA support on STM32H743 SoC
>>  -Change pinctrl pinmux entries for all SoC.
>
> Pulled into next/dt
>
>>  include/dt-bindings/pinctrl/stm32-pinfunc.h        |   30 +
>>  include/dt-bindings/pinctrl/stm32f429-pinfunc.h    | 1239 ---------------
>>  include/dt-bindings/pinctrl/stm32f746-pinfunc.h    | 1324 ----------------
>>  include/dt-bindings/pinctrl/stm32h7-pinfunc.h      | 1612 --------------------

[Hit 'send' too early]

I like the new way you handle the pinfunc, thanks for cleaning that up.

     Arnd
