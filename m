From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Apr 2018 11:13:12 +0800
Subject: [PATCH v6 03/11] ARM: dts: sun8i: Add R_CPUCFG device node for
 the A83T dtsi
In-Reply-To: <20180416215032.5023-4-mylene.josserand@bootlin.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-4-mylene.josserand@bootlin.com>
Message-ID: <CAGb2v67b_-RTF2HyNE5NoWTiHy9BDPR95sxvOYzGbz7=qP_ewA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 5:50 AM, Myl?ne Josserand
<mylene.josserand@bootlin.com> wrote:
> The R_CPUCFG is a collection of registers needed for SMP bringup
> on clusters and cluster's reset.
> For the moment, documentation about this register is found in
> Allwinner's code only.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
