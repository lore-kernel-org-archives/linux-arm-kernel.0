From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 9 Jan 2017 17:28:56 +0100
Subject: [PATCH v4 1/9] clk: stm32f4: Update DT bindings documentation
In-Reply-To: <20161222001051.GP8288@codeaurora.org>
References: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
 <1481638820-29324-2-git-send-email-gabriel.fernandez@st.com>
 <20161222001051.GP8288@codeaurora.org>
Message-ID: <ccd14adb-9d10-ae9e-de6d-565418421968@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 12/22/2016 01:10 AM, Stephen Boyd wrote:
> On 12/13, gabriel.fernandez at st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> Creation of dt include file for specific stm32f4 clocks.
>> These specific clocks are not derived from system clock (SYSCLOCK)
>> We should use index 1 to use these clocks in DT.
>> e.g. <&rcc 1 CLK_LSI>
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>
> Applied to clk-stm32f4 and merged into clk-next.
>

I'm preparing pull request branch for STM32 DT part. This patch is also 
requested to build correctly DT patches. Do you know how could we 
synchronize our pull request ?

Thanks
Alex
