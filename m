From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 5 Apr 2017 14:20:31 +0800
Subject: [linux-sunxi] [PATCH 02/11] arm64: allwinner: a64: add NMI
 controller on A64
In-Reply-To: <20170405061137.n66ectbkl7a2fv5f@lukather>
References: <20170404180145.12897-1-icenowy@aosc.io>
 <20170404180145.12897-3-icenowy@aosc.io>
 <CAGb2v67BucT8=FTgem3AmSU9XJA7OHoTCq3t3wBzDWyuwzZqaA@mail.gmail.com>
 <20170405061137.n66ectbkl7a2fv5f@lukather>
Message-ID: <CAGb2v672Z2JedGF3n+8Hi78QG_hAxz0ZYXaCkw0GAkA3xEdKrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 5, 2017 at 2:11 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Apr 05, 2017 at 11:51:45AM +0800, Chen-Yu Tsai wrote:
>> On Wed, Apr 5, 2017 at 2:01 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> > Allwinner A64 SoC features a NMI controller, which is usually connected
>> > to the AXP PMIC.
>> >
>> > Add support for it.
>> >
>> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>
>> This might not be the best representation of the R_INTC block. Though
>> we'd need to change it for all SoCs if we want to be accurate. For now,
>
> What do you think would be a good representation?

My gut feeling is that this is the old INTC from sun4/5i. It's supposed
to be the interrupt controller for the embedded low power core. I've not
done a thorough comparison though.

ChenYu
