From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 09 May 2014 09:10:22 -0700
Subject: [PATCH 68/97] ARM: l2c: sti: remove cache size override
In-Reply-To: <536CEBDF.2000307@st.com>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerHT-0001YK-DL@rmk-PC.arm.linux.org.uk> <535F4B20.9090904@linaro.org>
 <536CEBDF.2000307@st.com>
Message-ID: <536CFDEE.8030405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Maxime,
On 09/05/14 07:53, Maxime Coquelin wrote:
> Hi Srini,
>
> On 04/29/2014 08:48 AM, Srinivas Kandagatla wrote:
>> Hi Russell,
>> Thankyou for the patch,
>>
>> The only issue I see is, on most of the STi SOCs the default value for
>> AUXCTRL register is 0x0, so the waysize is not set.
> I checked all the ARM SoCs we support currently.
> Only STiH416 has its reset value at 0x0.
>
>>
>> The way size is different on some SOCs in the same series.
>>
>> Where is the way-size mentioned in this new style?
>
> Then, I think it should be the role of the bootloaders to set it for
> STiH416 (I have been told U-Boot already does it).
> Does it sound acceptable for you?

That's great, so the gdb startup scripts should takecare of it too.


Thanks,
srini
