From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 6 May 2014 10:20:27 +0200
Subject: [PATCH 1/9] ARM: STi: DT: STiH416: 416 DT Entry for clockgen
 A0/1/10/11/12
In-Reply-To: <20140506071843.GD5206@lee--X1>
References: <1399305223-18703-1-git-send-email-gabriel.fernandez@linaro.org>
 <1399305223-18703-2-git-send-email-gabriel.fernandez@linaro.org>
 <20140506071843.GD5206@lee--X1>
Message-ID: <CAG374jD+msPPbPtFS+ji=8jS9+D-YHu31k7zzzC7Ty7jw9n7jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 6 May 2014 09:18, Lee Jones <lee.jones@linaro.org> wrote:
>> Patch adds DT entries for clockgen A0/1/10/11/12
>>
>> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>> ---
>>  arch/arm/boot/dts/stih416-clks.h     |  15 ++
>
> This should live in include/dt-bindings/clk
>
include/dt-bindings/clk or  include/dt-bindings/clock ?

>>  arch/arm/boot/dts/stih416-clock.dtsi | 477 ++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/stih416.dtsi       |  10 +-
>>  3 files changed, 497 insertions(+), 5 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/stih416-clks.h
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

Best regards
