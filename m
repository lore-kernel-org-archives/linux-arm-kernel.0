From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Apr 2018 14:45:26 +0800
Subject: [PATCH v5 04/13] ARM: dts: sun8i: Add CPUCFG device node for A83T
 dtsi
In-Reply-To: <20180403061836.3926-5-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-5-mylene.josserand@bootlin.com>
Message-ID: <CAGb2v64kkm5qNNi-BD55nYUn9e=tfJZ8fKhJrs=mB=fMWrRBcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2018 at 2:18 PM, Myl?ne Josserand
<mylene.josserand@bootlin.com> wrote:
> As we found in sun9i-a80, CPUCFG is a collection of registers that are
> mapped to the SoC's signals from each individual processor core and
> associated peripherals.
>
> These registers are used for SMP bringup and CPU hotplugging.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
