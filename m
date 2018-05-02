From: robh@kernel.org (Rob Herring)
Date: Wed, 2 May 2018 07:41:43 -0500
Subject: [PATCH 1/2] dt-bindings: add MediaTek XS-PHY binding
In-Reply-To: <1525244660.25162.12.camel@mhfsdcap03>
References: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
 <1524642329-12255-2-git-send-email-chunfeng.yun@mediatek.com>
 <20180501142459.GA10534@rob-hp-laptop> <1525244660.25162.12.camel@mhfsdcap03>
Message-ID: <CAL_Jsq+_Bq_Cm7RT0aTstLcRvdpx62U-7CXUA5hJnO-UqW6E4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2018 at 2:04 AM, Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> Hi Rob,
> On Tue, 2018-05-01 at 09:24 -0500, Rob Herring wrote:
>> On Wed, Apr 25, 2018 at 03:45:28PM +0800, Chunfeng Yun wrote:
>> > Add a DT binding documentation of XS-PHY for MediaTek SoCs
>> > with USB3.1 GEN2 controller

[...]

>> > +   reg = <0 0x11c43000 0 0x0200>;
>> > +   mediatek,src-ref-clk-mhz = <26>;
>> > +   mediatek,src-coef = <17>;
>> > +   #address-cells = <2>;
>> > +   #size-cells = <2>;
>>
>> Really need 64-bit sizes?
> Just an example, 32-bit is also ok, but it's better to use the same
> value as the root node

Why is it better?

It is unnecessary bloat and it is better to limit the range of child
nodes using ranges.

Rob
