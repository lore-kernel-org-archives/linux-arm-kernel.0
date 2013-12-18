From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 18 Dec 2013 08:40:38 -0300
Subject: [PATCH v2 08/11] ARM: sun4i: dt: mod0 clocks
In-Reply-To: <20131218094847.GD2718@lukather>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
 <1387327503-15651-9-git-send-email-emilio@elopez.com.ar>
 <20131218094847.GD2718@lukather>
Message-ID: <52B189B6.5030807@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 18/12/13 06:48, Maxime Ripard escribi?:
> Hi Emilio,
>
> On Tue, Dec 17, 2013 at 09:45:00PM -0300, Emilio L?pez wrote:
>> This commit adds all the mod0 clocks present on sun4i to its device tree
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Even though I gave my Acked-by, could you rename the nodes to
> something like: "foo_clk: clk at deadbeef"
>
> The node name is supposed to be the class of devices, and we're likely
> to use all those labels for the actual controllers, and not the clocks
> themselves.

Ok, I'll get that fixed before sending v3.

Thanks!

Emilio
