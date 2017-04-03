From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 11:04:49 -0500
Subject: [PATCH v2] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <20170403143958.gi7vyhianzetnxz2@rob-hp-laptop>
References: <1490778502-23651-1-git-send-email-gabriel.fernandez@st.com>
 <20170403143958.gi7vyhianzetnxz2@rob-hp-laptop>
Message-ID: <CAL_JsqJYu+4puvB-WhaLVtjHASVOdY0acM2OxxMpZOvG9MAziQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 3, 2017 at 9:39 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Mar 29, 2017 at 11:08:22AM +0200, gabriel.fernandez at st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> This patch enables clocks for STM32H743 boards.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> Just for the MFD changes:
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>

>> +Required properties for pll node:
>> +- compatible: Should be:
>> +  "stm32h7-pll"
>
> stm,stm32h7-pll

Err, I meant st,stm32h7-pll.

>
> With that,
>
> Acked-by: Rob Herring <robh@kernel.org>
