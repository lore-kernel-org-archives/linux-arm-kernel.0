From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 20 Oct 2017 11:23:19 +0530
Subject: [GIT PULL 1/2] DaVinci DT updates for v4.15
In-Reply-To: <CAK8P3a1-gMtvpjHLKVU5cJM89g_LQN9qCFuNUZzGMj2MDbptcQ@mail.gmail.com>
References: <20171013140240.18599-1-nsekhar@ti.com>
 <CAK8P3a1-gMtvpjHLKVU5cJM89g_LQN9qCFuNUZzGMj2MDbptcQ@mail.gmail.com>
Message-ID: <c967abc0-7dab-9bf1-f497-750f18c04c28@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Friday 20 October 2017 03:51 AM, Arnd Bergmann wrote:
> On Fri, Oct 13, 2017 at 4:02 PM, Sekhar Nori <nsekhar@ti.com> wrote:
>>
>> ----------------------------------------------------------------
>> Add support for accessing DSP on DA850 SoC when using
>> device-tree.
> 
> Pulled into next/dt.
> 
>> Suman Anna (3):
>>       ARM: dts: da850: Add DSP node
>>       ARM: dts: da850-lcdk: Add and enable CMA reserved pool for DSP
>>       ARM: davinci: da8xx-dt: Add OF_DEV_AUXDATA entry for DSP clock matching
>>
>>  arch/arm/boot/dts/da850-lcdk.dts | 18 ++++++++++++++++++
>>  arch/arm/boot/dts/da850.dtsi     | 12 ++++++++++++
>>  arch/arm/mach-davinci/da8xx-dt.c |  1 +
> 
> What is your longterm plan for the clocks? Is anyone working on converting
> that clock driver to properly support DT clocks?

Not at the moment. But I am working to get some resources behind this.
Right now I hope to see this done by mid-next year.

Thanks,
Sekhar
