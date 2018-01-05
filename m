From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Fri, 5 Jan 2018 09:21:11 +0100
Subject: [PATCH 05/12] arm64: dts: mt7622: add PMIC MT6380 related nodes
In-Reply-To: <1515123759.30687.71.camel@mtkswgap22>
References: <cover.1515057696.git.sean.wang@mediatek.com>
 <0109846a8a501ca3cae33acfceb919960fddfcbf.1515057696.git.sean.wang@mediatek.com>
 <CAOFm3uF0WHO6_Y6dKu3DnAd759tA2hNQs=0-P86s1A0e==27Ow@mail.gmail.com>
 <1515123759.30687.71.camel@mtkswgap22>
Message-ID: <CAOFm3uEkqKGhsziwf6o3i2o0Ua=ah4CHgh-Hr+aC4zHxH3mZzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sean,

On Fri, Jan 5, 2018 at 4:42 AM, Sean Wang <sean.wang@mediatek.com> wrote:
> On Thu, 2018-01-04 at 11:27 +0100, Philippe Ombredanne wrote:
>> Sean,
>>
>> On Thu, Jan 4, 2018 at 10:40 AM,  <sean.wang@mediatek.com> wrote:
>> > From: Sean Wang <sean.wang@mediatek.com>
>> >
>> > Enable pwrap and MT6380 on mt7622-rfb1 board. Also add all mt6380
>> > regulator nodes in an alone file to allow similar boards using MT6380
>> > able to resue the configuration.
>> >
>> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> > Cc: Mark Brown <broonie@kernel.org>
>> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> > ---
>> >  arch/arm64/boot/dts/mediatek/mt6380.dtsi     | 91 ++++++++++++++++++++++++++++
>> >  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts |  8 +++
>> >  arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 12 ++++
>> >  3 files changed, 111 insertions(+)
>> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6380.dtsi
>> >
>> > diff --git a/arch/arm64/boot/dts/mediatek/mt6380.dtsi b/arch/arm64/boot/dts/mediatek/mt6380.dtsi
>> > new file mode 100644
>> > index 0000000..7eb7dc2
>> > --- /dev/null
>> > +++ b/arch/arm64/boot/dts/mediatek/mt6380.dtsi
>> > @@ -0,0 +1,91 @@
>> > +/*
>> > + * Copyright (c) 2018 MediaTek Inc.
>> > + * Author: Chenglin Xu <chenglin.xu@mediatek.com>
>> > + *        Sean Wang <sean.wang@mediatek.com>
>> > + *
>> > + * This program is free software; you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2 as
>> > + * published by the Free Software Foundation.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + */
>>
>> Would you mind using SPDX tags instead of this fine but long legalese?
>> This is documented in Thomas patches [1].
>
>> Also if you could spread the word in your team, this would earn you
>> good karma points.
>> Thank you!
>>
>> [1] https://lkml.org/lkml/2017/12/28/323
>
>
> Hi, Philippe
>
> thanks for your suggestion
>
> Certainly, this can be replaced with
>
> SPDX-License-Identifier: GPL-2.0
>
> most drivers from MediaTek use the similar disclaimer, it should be fine
> to use SPDX tags instead.
>
>         Sean
>

Thank you! that's great.

-- 
Cordially
Philippe Ombredanne
