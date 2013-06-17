From: tj@kernel.org (Tejun Heo)
Date: Mon, 17 Jun 2013 11:27:19 -0700
Subject: [v1 2/3] ata: ahci_platform: enable imx6q ahci sata support
In-Reply-To: <1371462767-16630-3-git-send-email-r65037@freescale.com>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
 <1371462767-16630-3-git-send-email-r65037@freescale.com>
Message-ID: <CAOS58YM+ih4vLD8v5u08FS0JMcrwYNHo31zOmDd5VAed+NKbtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 2:52 AM, Richard Zhu
<richard.zhuhongxing@gmail.com> wrote:
> imx6q contains the Synopsys AHCI SATA controller which shares
> ahci_platform driver with other controllers.
>
> This patch updates the DT compatible list for ahci_platform,
> and enable the imx6q ahci sata support.
>
> Signed-off-by: Richard Zhu <r65037@freescale.com>

I suppose this better be routed with the rest of the series through
the arch tree?  If not, please let me know.

Acked-by: Tejun Heo <tj@kernel.org>

There probably will be a merge conflict but it's gonna be very
trivial, so no worries.

Thanks.

--
tejun
