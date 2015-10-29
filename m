From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 29 Oct 2015 11:11:18 -0200
Subject: [PATCH] ARM: add v7 LPAE multi-platform defconfig
In-Reply-To: <1445956507-34026-1-git-send-email-b18965@freescale.com>
References: <1445956507-34026-1-git-send-email-b18965@freescale.com>
Message-ID: <CAOMZO5ACSg0VmYV=5Q=gWtP5OZdUXkXa_SDmTC-t8gbzmLVdEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 12:35 PM, Alison Wang <b18965@freescale.com> wrote:
> v7 LPAE multi-platform defconfig is based on v7 multi-platform
> defconfig and adds LPAE support.
>
> This defconfig is verified on LS1021A which enables GIANFAR,
> I2C, WATCHDOG, AUDIO, EDMA and DSPI drivers, etc.
>
> Signed-off-by: Alison Wang <alison.wang@freescale.com>

Much better now without CONFIG_VMSPLIT_2G=y :-)

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
