From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Jun 2017 13:34:52 -0300
Subject: [PATCH v5 2/3] ARM: dts: imx7: add GPMI NAND and APBH DMA
In-Reply-To: <151ddece1e1427d0b69c4ff11b86a69b6a035d0d.1496730576.git-series.stefan@agner.ch>
References: <cover.b62c3a17bd60de48d8fb2ade6dde4f2bc60aaf3c.1496730576.git-series.stefan@agner.ch>
 <151ddece1e1427d0b69c4ff11b86a69b6a035d0d.1496730576.git-series.stefan@agner.ch>
Message-ID: <CAOMZO5Ai-_5j3gQviaq19y7MJmirRgBtUp59UYmuGaN3Fd5Sag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 3:30 AM, Stefan Agner <stefan@agner.ch> wrote:
> Add i.MX 7 APBH DMA and GPMI NAND modules.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Tested on a imx7d-sdb:

[    1.303543] nand: device found, Manufacturer ID: 0xec, Chip ID: 0xd5
[    1.309999] nand: Samsung NAND 2GiB 3,3V 8-bit
[    1.314467] nand: 2048 MiB, MLC, erase size: 256 KiB, page size:
2048, OOB size: 64
[    1.346007] gpmi-nand 33002000.gpmi-nand: driver registered.

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
