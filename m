From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 26 Feb 2013 21:08:14 +0900
Subject: [PATCH/RFC v2 0/2] CPUFreq for kzm9g
In-Reply-To: <Pine.LNX.4.64.1302251644010.3030@axis700.grange>
References: <Pine.LNX.4.64.1302251644010.3030@axis700.grange>
Message-ID: <CANqRtoSpu3V5KC-POq7+y0NpRx6yNfdZFfgaxa7Lv1gU1rO53Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 2:16 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> In v2 of this patch-set I dropped patches 1 and 3, because #1 is a bug-fix
> and can go in separately, #3 is more of a debugging help, than a real
> patch for mainlining. Of the remaining 2 patches the main difference to v1
> is the omission of the PLL0 manipulation. More is explained in respective
> patches.
>
> Guennadi Liakhovetski (2):
>   ARM: shmobile: sh73a0: add support for adjusting CPU frequency
>   ARM: shmobile: kzm9g-reference: add CPUFreq support

Hi Guennadi,

Thanks for your work on this. In general I am quite happy about this series.

One rather significant question is however this: Would it be possible
for you to check if the TWD is operating as expected when you scale
the CPU Frequency? I suspect it is not, so please cook up a v3 of this
series that also includes updates for timers.

Cheers,

/ magnus
