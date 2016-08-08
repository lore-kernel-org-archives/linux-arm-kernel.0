From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 8 Aug 2016 21:54:54 +0300
Subject: [PATCH v3 0/6] Add R8A7794/SILK sound DT support
In-Reply-To: <20160808105901.GH17838@verge.net.au>
References: <3910788.ckTpUWEs6B@wasted.cogentembedded.com>
 <87y44l2uy1.wl%kuninori.morimoto.gx@renesas.com>
 <20160808105901.GH17838@verge.net.au>
Message-ID: <f2d0ede3-6776-6c50-cdbc-2825295182ce@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2016 01:59 PM, Simon Horman wrote:

>>>    Here's the set of 6 patches against Simon Horman's 'renesas.git' repo,
>>> 'renesas-devel-20160725-v4.7-rc7' tag. I'm adding the sound device tree support
>>> for the R8A7794 SoC based SILK board.
>>>
>>> [1/6] ARM: dts: r8a7794: add audio clocks
>>> [2/6] ARM: dts: r8a7794: add MSTP5 clocks
>>> [3/6] ARM: dts: r8a7794: add MSTP10 clocks
>>> [4/6] ARM: dts: r8a7794: add Audio-DMAC support
>>> [5/6] ARM: dts: r8a7794: add sound support
>>> [6/6] ARM: dts: silk: add sound support
>>
>> For all patches
>>
>> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Thanks, I have queued these up.

    Great, TY!
    However, I noticed that the the latest devel tag is said to be still based 
on v4.7-rc7 while in practice it's based on v4.8-rc1...

MBR, Sergei
