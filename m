From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Jun 2012 15:33:33 -0300
Subject: [PATCH 1/4] serial: imx: Remove unneeded '#ifdef CONFIG_OF'
In-Reply-To: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
References: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAOMZO5Cj_YaO+sn+wRzb-uRBcFDc75gsJ1AeuTEPc2a8YRpEVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 2:23 PM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> CONFIG_OF is always selected for imx SoCs so it is safe
> to drop the '#ifdef CONFIG_OF'.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: <linux-serial@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Please discard this series.
