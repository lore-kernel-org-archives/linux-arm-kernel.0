From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 May 2017 13:07:56 -0300
Subject: [PATCH] [RFC] ARM: dts: imx6sx-sdb: Drop OPP hackery
In-Reply-To: <20170425164224.26537-1-marex@denx.de>
References: <20170425164224.26537-1-marex@denx.de>
Message-ID: <CAOMZO5Dt961k4k=SX6M23c287pXjOcsTRG_xEMXmYbVexc6k7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 1:42 PM, Marek Vasut <marex@denx.de> wrote:
> The imx6sx-sdb has one power supply that drives both VDDARM_IN
> and VDDSOC_IN, which is the sw1a regulator on the PFUZE PMIC.
> Connect both inputs to the sw1a regulator on the PMIC and drop
> the OPP hackery which is no longer needed as the power framework
> will take care of the regulator configuration as needed.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
