From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Dec 2017 13:12:06 -0200
Subject: [PATCH] ARM: imx: remove unused imx3 pm definitions
In-Reply-To: <1513678024-2779-1-git-send-email-martin@kaiser.cx>
References: <1513678024-2779-1-git-send-email-martin@kaiser.cx>
Message-ID: <CAOMZO5D2TJDAtZ47FWeQ18Tf+F2BydZH-gtj38b18ijZxqUiEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 8:07 AM, Martin Kaiser <martin@kaiser.cx> wrote:
> Remove the defintion of mx3_cpu_lp_set(), this function is not
> implemented anywhere. Remove then mx3_cpu_pwr_mode enum as well,
> it was used only as parameter of mx3_cpu_lp_set().
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
