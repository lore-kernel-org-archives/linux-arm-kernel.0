From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Thu, 5 Jun 2014 09:51:09 +0200
Subject: [STLinux Kernel] [PATCH RESEND 06/12] drivers: clk: st: Add
 polarity bit indication
In-Reply-To: <20140605074516.GA3865@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1401892320-18211-1-git-send-email-gabriel.fernandez@linaro.org>
 <1401892320-18211-7-git-send-email-gabriel.fernandez@linaro.org>
 <20140605074516.GA3865@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <5390216D.9020306@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/05/2014 09:45 AM, Peter Griffin wrote:
> Hi Gabi,
>
> On Wed, 04 Jun 2014, Gabriel FERNANDEZ wrote:
>
>> This patch introduces polarity indication for pll power up bit
>> and for standby bit in order to have same code between Orly 2
>> and CAN.
> I think it would be better to refer to the SoC's by there numeric
> name stih416 and stih407, as people unfamiliar with ST SoC names
> reading the commit message are unlikely to know what Orly2 or CAN
> mean.
>
> Once fixed you can add my:
> Acked-by: Peter Griffin <peter.griffin@linaro.org>

Ok thanks Peter

> regards,
>
> Peter.
>
