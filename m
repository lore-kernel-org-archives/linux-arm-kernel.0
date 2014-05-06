From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 6 May 2014 17:48:05 +0200
Subject: [PATCH 0/4] Enable ST Keyscan driver
In-Reply-To: <5368D806.8050609@linaro.org>
References: <1399304320-18197-1-git-send-email-gabriel.fernandez@linaro.org>
 <5368D806.8050609@linaro.org>
Message-ID: <53690435.5040602@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini,

	I will prepare the branch next week for the pull request.

Thanks,
Maxime

On 05/06/2014 02:39 PM, Srinivas Kandagatla wrote:
> All the DT patches look good for me.
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> I think It will be better to send a pull request to Arnd/Olof including
> other reviewed DT patches.
>
> thanks,
> srini
>
>
> On 05/05/14 16:38, Gabriel FERNANDEZ wrote:
>> The goal of this series is to enable ST Keyscan support to ST SoCs.
>> The DT definition is added for STiH415 and STiH416 SoCs on
>> B2000 board.
>> Tested on B2000 sti board.
>>
>> Gabriel Fernandez (4):
>>    ARM: STi: DT: add keyscan for stih415
>>    ARM: STi: DT: add keyscan for stih416
>>    ARM: STi: DT: add keyscan for stih41x-b2000
>>    ARM: multi_v7_defconfig: add ST Keyscan driver
>>
>>   arch/arm/boot/dts/stih415-pinctrl.dtsi | 16 ++++++++++++++++
>>   arch/arm/boot/dts/stih415.dtsi         | 12 ++++++++++++
>>   arch/arm/boot/dts/stih416-pinctrl.dtsi | 16 ++++++++++++++++
>>   arch/arm/boot/dts/stih416.dtsi         | 12 ++++++++++++
>>   arch/arm/boot/dts/stih41x-b2000.dtsi   | 23 +++++++++++++++++++++++
>>   arch/arm/configs/multi_v7_defconfig    |  1 +
>>   6 files changed, 80 insertions(+)
>>
