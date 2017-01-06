From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 6 Jan 2017 16:01:32 +0200
Subject: [PATCH v5 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
In-Reply-To: <20170106135357.n4ugkcdcog4hzbhe@gangnam.samsung>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134356epcas1p19be459900aec43b2b9ea343cdaf0a2bf@epcas1p1.samsung.com>
 <20170106134350.32428-3-andi.shyti@samsung.com>
 <20170106134929.mj7wqalp7lpkfm6b@kozik-lap>
 <20170106135357.n4ugkcdcog4hzbhe@gangnam.samsung>
Message-ID: <CAJKOXPc9rPsqb1OVYKqMA2vs3J87=fxcr8cy+0mZjhOU7sa_Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 6, 2017 at 3:53 PM, Andi Shyti <andi.shyti@samsung.com> wrote:
> Hi Krzysztof,
>
>> > -#include "exynos5433-tm2.dts"
>> > +#include "exynos5433-tm2-common.dtsi"
>> >
>> >  / {
>> >     model = "Samsung TM2E board";
>>
>> Where are the regulators?
>
> No need, they were already overwriting the original property, so
> with your suggestion they didn't change in tm2e. That's why I like
> your suggestion.
>
> Originally I added the 'regulator' label to not have empty nodes.

Yes, I understand, I spotted it right now. Everything looks good, thanks.

Applied.

BR,
Krzysztof
