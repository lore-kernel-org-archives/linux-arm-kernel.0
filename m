From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 May 2015 12:20:50 -0300
Subject: [PATCH 1/1] ARM: clk-imx6q: refine sata's parent
In-Reply-To: <1432132237-31004-1-git-send-email-sebastien.szymanski@armadeus.com>
References: <1432132237-31004-1-git-send-email-sebastien.szymanski@armadeus.com>
Message-ID: <CAOMZO5ByAL=-EXUiEoKnWVWbcpLPKDxQShPf_FPDhmHmiG3bmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 11:30 AM, S?bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
> According to IMX6D/Q RM, table 18-3, sata clock's parent is ahb, not ipg.

Good catch!

>
> This patch is based on branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/soc

Please put this below the --- line.

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
