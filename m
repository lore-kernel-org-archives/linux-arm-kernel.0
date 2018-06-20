From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Jun 2018 17:31:52 -0300
Subject: [PATCH v3] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
In-Reply-To: <20180620202045.27965-1-nick@shmanahar.org>
References: <20180620194239.2730-1-nick@shmanahar.org>
 <20180620202045.27965-1-nick@shmanahar.org>
Message-ID: <CAOMZO5BTMRJmrjM7X3-7Qi1wuciOnLZhAUuWN27Dtoc0cZXVSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 5:20 PM, Nick Dyer <nick@shmanahar.org> wrote:
> The pinctrl settings were incorrect for the touchscreen interrupt line, causing
> an interrupt storm. This change has been tested with both the atmel_mxt_ts and
> RMI4 drivers on the RDU1 units.
>
> The value 0x4 comes from the value of register IOMUXC_SW_PAD_CTL_PAD_CSI1_D8
> from the old vendor kernel.
>
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> Fixes: ceef0396f367 ("ARM: dts: imx: add ZII RDU1 board")
> Cc: <stable@vger.kernel.org> # 4.15+

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
