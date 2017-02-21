From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 21 Feb 2017 12:50:28 +0800
Subject: [PATCH v3 17/18] ARM: dts: sun8i: sina33: enable battery power
 supply subnode
In-Reply-To: <20170214094112.27426-18-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-18-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v64SnsrckN7+cv5woHzLTWrM455xjUQFh3dKHUNhjgBB7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 5:41 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The Sinlinx SinA33 has an AXP223 PMIC and a battery connector, thus, we
> enable the battery power supply subnode in its Device Tree.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Battery charger enabled without any description of the associated battery...
In this case I think the driver should use the lowest charge current to be
safe?

Acked-by: Chen-Yu Tsai <wens@csie.org>
