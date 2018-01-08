From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 8 Jan 2018 16:26:16 +0800
Subject: [PATCH] ARM: dts: sun[47]i: Fix display backend 1 output to TCON0
 remote endpoint
In-Reply-To: <20180104132752.pcixtjugwfvlshpl@flea.lan>
References: <20180103163155.13975-1-wens@csie.org>
 <20180104132752.pcixtjugwfvlshpl@flea.lan>
Message-ID: <CAGb2v66HQ1+u--dLzVn8tjG+fYvdeYPuUkV4p-Zc1ctOsrSXrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 4, 2018 at 9:27 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Jan 04, 2018 at 12:31:55AM +0800, Chen-Yu Tsai wrote:
>> There is a copy-paste error in the display pipeline device tree graph.
>> The remote endpoint of the display backend 1's output to TCON0 points
>> to the wrong endpoint. This will result in the driver incorrectly
>> parsing the relationship of the components.
>>
>> Reported-by: Andrea Venturi <ennesimamail.av@gmail.com>
>> Fixes: 0df4cf33a594 ("ARM: dts: sun4i: Add device nodes for display
>>                     pipelines")
>> Fixes: 5b92b29bed45 ("ARM: dts: sun7i: Add device nodes for display
>>                     pipelines")
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied (a few days ago).

This will be sent out in a pull request later.

ChenYu
