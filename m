From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Aug 2018 10:32:44 -0300
Subject: [PATCH] ARM: dts: imx7d-sdb: enable gpio buttons as wakeup source
In-Reply-To: <1535507138-4626-1-git-send-email-Anson.Huang@nxp.com>
References: <1535507138-4626-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5DvoxbSCLDDaMy9LnYRpHQR+Yr47qzZGtK_OD6WBGE7tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 10:45 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> This patch enables i.MX7D SDB board's below GPIO buttons
> as wakeup sources:
>
> S1(FUNC1): KEY_VOLUMEUP
> S3(FUNC2): KEY_VOLUMEDOWN
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
