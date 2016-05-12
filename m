From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 13 May 2016 00:16:17 +0300
Subject: [PATCH v3 0/6] Add R8A7794/SILK sound DT support
In-Reply-To: <2378837.cigT3tNQPe@wasted.cogentembedded.com>
References: <2378837.cigT3tNQPe@wasted.cogentembedded.com>
Message-ID: <7d19e749-8264-9004-64f4-aefabda699c6@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/12/2016 11:38 PM, Sergei Shtylyov wrote:

>    Here's the set of 6 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20160509-v4.6-rc7' tag. I'm adding the sound device tree support
> for the R8A7794 SoC based SILK board.
>
> [1/6] ARM: dts: r8a7794: add audio clocks
> [2/6] ARM: dts: r8a7794: add MSTP5 clocks
> [3/6] ARM: dts: r8a7794: add MSTP10 clocks
> [4/6] ARM: dts: r8a7794: add Audio-DMAC support
> [5/6] ARM: dts: r8a7794: add sound support
> [6/6] ARM: dts: silk: add sound support

    Oops, forgot to mention that patch #5 depends on the R-Car sound patch 
posted yesterday in order to get interpreted as intended (it uses a disabled 
SRC node).

WBR, Sergei
