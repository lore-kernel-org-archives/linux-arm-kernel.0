From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 12 Oct 2017 16:36:35 +0800
Subject: [PATCH v2 0/5] sunxi: Cleanup DT warnings for the A10 and A80
In-Reply-To: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
References: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65EGBBoqyVo+_FuEJQoATyYKGhf-J-hA6DQgGuCkQf=3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 4:22 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> We've had quite a big number of warnings in our device trees due to some
> convention that was added before any kind of warning was introduced, and
> went on since.
>
> Some of our newest SoC will not generate any warning but the unavoidable
> ones (generic properties with underscores, mostly, like USB OTG dr_mode).
>
> However, most of them just needed some cleanup. Here is a serie that would
> clean two of these SoCs (plus one SoC-tree wide change).
>
> This brings down the number of DTC warnings with W=2 from 10482 to 4504,
> which is a nice stat, but will obviously need some more work.
>
> Let me know what you think,
> Maxime
>
> Changes from v1:
>   - Dropped the patches merged
>   - Reworked a bit the commit logs
>   - Removed the changes to the LDO node names
>   - Renamed the PS2 pins names
>
> Maxime Ripard (5):
>   ARM: dts: sun4i: Change pinctrl nodes to avoid warning
>   ARM: dts: sun4i: Provide default muxing for relevant controllers
>   ARM: dts: sun4i: Remove underscores from nodes names
>   ARM: dts: sun9i: Change node names to remove underscores
>   ARM: dts: sun9i: Change node names to remove underscores

Acked-by: Chen-Yu Tsai <wens@csie.org>
