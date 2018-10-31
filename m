From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 Oct 2018 11:05:11 +0800
Subject: [PATCH v5 07/11] arm64: dts: allwinner: a64: sopine-baseboard:
 enable power supplies
In-Reply-To: <20181023185330.10472-8-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-8-oskari@lemmela.net>
Message-ID: <CAGb2v66dY87HN6HQz3=ER=yr6arV3LcxCxpVVwojKpqwj7m7dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 2:54 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 ACIN pins are routed from SOM to the DC jack on the baseboard.
> AXP803 charger pins BATSENSE, LOADSENSE, N_BATDRV, LX_CHG, VIN_CHG
> and IPSOUT are connected via PMOS driver to SOM VBAT pins. VBAT and
> AXP803 TS pins are routed to the baseboard 3-pin battery connector.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
