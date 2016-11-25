From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 18:05:22 +0800
Subject: [PATCH 08/10] ARM: dts: sun8i-a33-sinlinx-sina33: use AXP223 DTSI
In-Reply-To: <20161125090921.23138-9-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-9-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v64cStm1R9Y_dwSp+1tFq7Q=L4Vda75LhzQEHzoS7MWqEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Previously, the Sinlinx SinA33 used everything declared in AXP221 DTSI
> while it has an AXP223 PMIC.
>
> This corrects that so the Sinlinx SinA33 can get some features the
> AXP223 has (at the moment, ability to have 100mA as maximal current on
> VBUS power supply).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
