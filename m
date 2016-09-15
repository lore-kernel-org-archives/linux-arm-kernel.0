From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 15 Sep 2016 13:42:20 +0200
Subject: [PATCH v3 00/14] Clock improvement for video playback
In-Reply-To: <af43c05e-4485-d756-3362-19a76aa40307@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
 <20160914183620.GV7243@codeaurora.org>
 <af43c05e-4485-d756-3362-19a76aa40307@st.com>
Message-ID: <8257df40-272d-af63-d9b7-13d6aaea39a2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/15/2016 08:57 AM, Patrice Chotard wrote:
> 
> 
> On 09/14/2016 08:36 PM, Stephen Boyd wrote:
>> On 08/29, gabriel.fernandez at st.com wrote:
>>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>>
>>> v3:
>>>   - Rebase to v4.8-rc1
>>>   - Tipo fix in st,clkgen-pll.txt
>>>   - Add Ack of Peter for the series
>>>   - Add missed patch: "ARM: DT: STiH4xx: Simplify clock binding of STiH4xx platforms"
>>>
>>> v2:
>>>   - Simpliflication of clock binding
>>>     remark from Rob https://lkml.org/lkml/2016/5/25/492
>>>   - Suppression of stih415-416 support for the clocks (in order
>>> 	to help simplification of clock binding)
>>>     (others patchs for the machine and drivers will come)
>>>
>>> This serie allows to increase video resolutions and make audio
>>> adjustment during a video playback.
>>>
>>> Gabriel Fernandez (14):
>>>   drivers: clk: st: Remove stih415-416 clock support
>>>   drivers: clk: st: Simplify clock binding of STiH4xx platforms
>>>   ARM: DT: STiH4xx: Simplify clock binding of STiH4xx platforms
>>>   drivers: clk: st: Add fs660c32 synthesizer algorithm
>>>   drivers: clk: st: Add clock propagation for audio clocks
>>>   drivers: clk: st: Handle clk synchronous mode for video clocks
>>>   ARM: DT: STiH407: Enable clock propagation for audio clocks
>>>   ARM: DT: STiH410: Enable clock propagation for audio clocks
>>>   ARM: DT: STiH418: Enable clock propagation for audio clocks
>>>   ARM: DT: STiH407: Enable synchronous clock mode for video clocks
>>>   ARM: DT: STiH410: Enable synchronous clock mode for video clocks
>>>   ARM: DT: STiH418: Enable synchronous clock mode for video clocks
>>>   ARM: DT: STi: STiH407: clock configuration to address 720p and 1080p
>>>   ARM: DT: STi: STiH410: clock configuration to address 720p and 1080p
>>
> 
> Hi Stephen
> 
>> The order of patches intermingles clk changes and dts changes.
>> I'd prefer to not take any patches for dts through the clk tree,
>> so can those be deferred to an arm-soc PR? 
> 
> No problem, i will take all DTS patches and submit a pull request to arm-soc.
> 
> Assuming that works,
>> I'd just pick 1-2, and 4-6 into the clk tree and the rest can go
>> on top through arm-soc.

Stephen

Just to confirm, these patches will be merged into clk-next tree ? so dedicated for v4.9 ?

Thanks

Patrice

>>
> 
> Perfect 
> 
> Thanks
> 
> 
> 
