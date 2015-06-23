From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 23 Jun 2015 09:31:24 +0200
Subject: [STLinux Kernel] [PATCH 7/8] cpufreq: st: Provide runtime
 initialised driver for ST's platforms
In-Reply-To: <20150623071647.GD3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>	<1434987837-24212-8-git-send-email-lee.jones@linaro.org>	<20150623025031.GD16776@linux>
 <20150623071647.GD3245@x1>
Message-ID: <55890B4C.5000406@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/23/2015 09:16 AM, Lee Jones wrote:
> Thanks for your timely review Viresh.
>
> On Tue, 23 Jun 2015, Viresh Kumar wrote:
>> On 22-06-15, 16:43, Lee Jones wrote:
>>> +config ARM_ST_CPUFREQ
>>> +	bool "ST CPUFreq support"
>> Isn't using ST just too generic? There are multiple SoCs ST has been
>> involved with, I have worked on a completely different series.
>> Probably a more relative string is required here, like stih407 ?
> This is ST's only CPUFreq implementation and is pretty board
> agnostic.  This particular driver only currently supports the STiH407
> family, but internally it supports some others too.  I'll have a chat
> and see if we can make it more specific somehow.
I think you can use STI instead.

Regards,
Maxime
