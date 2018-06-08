From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 Jun 2018 14:28:57 -0300
Subject: [PATCH 2/2] imx_v6_v7_defconfig: Enable imx6qdl-sabreauto sensors
In-Reply-To: <70b90919f98a6941425b39065dc8d37c95f0fd9f.1528390418.git.leonard.crestez@nxp.com>
References: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
 <70b90919f98a6941425b39065dc8d37c95f0fd9f.1528390418.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5Anr6BQ=7XWB8hQSaV6m5b1fwji1RBwSj7vZU2zdAVnTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2018 at 2:00 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> CONFIG_SENSORS_ISL29018 supports isil,il29023 light sensor
> CONFIG_MMA8452 supports fsl,mma8451 accelerometer
>
> CONFIG_MAG3110 for fsl,mag3110 is already enabled
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Just a minor nit in the Subject. The "ARM" prefix is missing.

Maybe Shawn can adjust it when applying the patch.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
