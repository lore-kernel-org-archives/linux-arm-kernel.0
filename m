From: patrice.chotard@st.com (Patrice Chotard)
Date: Mon, 11 Jul 2016 09:38:24 +0200
Subject: [GIT PULL v2] STi SoC changes for v4.8
In-Reply-To: <11314287.lfBJrM5UFT@wuerfel>
References: <577E01B5.2030206@st.com> <11314287.lfBJrM5UFT@wuerfel>
Message-ID: <57834CF0.9090508@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/07/2016 03:23 PM, Arnd Bergmann wrote:
> On Thursday, July 7, 2016 9:16:05 AM CEST Patrice Chotard wrote:
>> Highlights:
>> -----------
>> - Add a dummy L2 cache's write_sec callback as in non secure mode execution,
>>     we can't get access to L2 cache secure registers
>> - Cosmetics change, in case of dump_stack, update the hardware name with a
>>     more generic for the STi SoCs family
>>
> This is also based on -rc5, please send a third version rebased to -rc3 or
> earlier.

Hi Arnd

V3 will be send shortly

Thanks

Patrice

>
> 	Arnd
