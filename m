From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 3 Nov 2016 13:45:04 +0000
Subject: [PATCH V3 1/6] clk: tegra: add TEGRA20_CLK_NOR to init table
In-Reply-To: <CALw8SCWC7RmNLVv4vxO9xw3jHVkgCaevbL61sJcpcva9CiaAVQ@mail.gmail.com>
References: <1477576872-2665-1-git-send-email-mirza.krak@gmail.com>
 <1477576872-2665-2-git-send-email-mirza.krak@gmail.com>
 <df12a1f0-316d-64a4-54fe-f7559742eeca@nvidia.com>
 <CALw8SCWyLAw=yZ-W_nAFuDAazpa4HJfZuzqLDKQKYLWjV5JzYw@mail.gmail.com>
 <CALw8SCWC7RmNLVv4vxO9xw3jHVkgCaevbL61sJcpcva9CiaAVQ@mail.gmail.com>
Message-ID: <db982af8-28e1-bc63-3272-d40cb640dd45@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/11/16 12:30, Mirza Krak wrote:
> 2016-11-03 13:26 GMT+01:00 Mirza Krak <mirza.krak@gmail.com>:
>> 2016-11-03 11:06 GMT+01:00 Jon Hunter <jonathanh@nvidia.com>:
>>> Hi Mirza,
>>>
>>> On 27/10/16 15:01, Mirza Krak wrote:
>>>>
>>>> From: Mirza Krak <mirza.krak@gmail.com>
>>>>
>>>> Add TEGRA20_CLK_NOR to init table and set default rate to 92 MHz which
>>>> is max rate.
>>>>
>>>> The maximum rate value of 92 MHz is pulled from the downstream L4T
>>>> kernel.
>>>
>>>
>>> Thanks for adding this. I assume that this is from an L4T r16 release with a
>>> v3.1 kernel. I had a quick poke through the kernel sources for v3.1 but was
>>> unable to see where this is set. Obviously v3.1 did not have CCF and so
>>> everything seems to be in the arch/arm/mach-tegra directory for setting up
>>> clocks. Can you point me to the appropriate sources so I can ACK this?
>>
>> I use the kernel sources provided by Toradex, and these sources are
>> based on L4T r16 release.
>>
>> http://git.toradex.com/cgit/linux-toradex.git/tree/arch/arm/mach-tegra/tegra2_clocks.c?h=tegra#n2463
>
> Ops, pre-mature send.
>
> I also added Marcel from Toradex on CC.
>
> The link to the source are [1] for Tegra2 and  [2] for Tegra3.
>
> [1]. http://git.toradex.com/cgit/linux-toradex.git/tree/arch/arm/mach-tegra/tegra2_clocks.c?h=tegra#n2463
> [2]. http://git.toradex.com/cgit/linux-toradex.git/tree/arch/arm/mach-tegra/tegra3_clocks.c?h=tegra#n4353

Great. Yes I see the same. Thanks!

Jon

-- 
nvpublic
