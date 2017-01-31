From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 31 Jan 2017 13:03:37 +0800
Subject: [PATCH v2 15/25] ARM: sun5i: chip: enable ACIN power supply
 subnode
In-Reply-To: <20170127085458.18270-16-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-16-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v66f2W_uqcX_GP1ZMUUhPkfGGNA7mvf2=6uabZ8Hk6zgnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 4:54 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The NextThing Co. CHIP has an AXP209 PMIC and can be power-supplied by
> ACIN via the CHG-IN pin.
>
> This enables the ACIN power supply subnode in the DT.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
