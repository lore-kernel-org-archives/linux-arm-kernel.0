From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 5 Jun 2016 11:04:32 -0300
Subject: [PATCH RFT 3/4] ARM: dts: imx28-cfa10049: fix dtc warning
In-Reply-To: <1465134715-13497-1-git-send-email-stefan.wahren@i2se.com>
References: <1465134715-13497-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAOMZO5DQ7M-JggN2cCLQ21HiXLywn8b-uVrLy+2p5Lz8c6VqGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 5, 2016 at 10:51 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This fixes the following dtc warning by removing the unnecessary unit:
>
> Warning (unit_address_vs_reg): Node /onewire at 0 has a unit name,
> but no reg property
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
