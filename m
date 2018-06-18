From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2018 12:47:10 -0300
Subject: [PATCH] ARM: dts: imx6: RIoTboard Add chosen stdout-path property
In-Reply-To: <20180618154257.16919-1-manu@freebsd.org>
References: <20180618154257.16919-1-manu@freebsd.org>
Message-ID: <CAOMZO5Bt+7FGT4Xk7HZdVjukNsG=eY5-P+9Qnig6h-cQSJvOvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 12:42 PM, Emmanuel Vadot <manu@freebsd.org> wrote:
> The RIoTboard debug uart is connected to serial1.
> Add a chosen property in the DTS so OS knows what serial port to use for
> the console.
>
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
