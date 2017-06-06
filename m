From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Jun 2017 15:38:19 -0300
Subject: [PATCH v2 1/2] ARM: imx: Add MXC_CPU_IMX6ULL and cpu_is_imx6ull
In-Reply-To: <1b0dac2d2236f86c87b066a95f33bd80a5ad5c6b.1496771145.git.leonard.crestez@nxp.com>
References: <cover.1496771145.git.leonard.crestez@nxp.com>
 <1b0dac2d2236f86c87b066a95f33bd80a5ad5c6b.1496771145.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5D6FeL0cA_pK2V7tjPmGs7K6R=EO8K4jh60kdQuVi=dig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 2:50 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> Support for imx6ull is already present but it's based on
> of_machine_is_compatible("fsl,imx6ull") checks. Add it to the MXC_CPU_*
> enumeration as well.
>
> This also fixes /sys/devices/soc0/soc_id reading "Unknown".
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
