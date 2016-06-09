From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 9 Jun 2016 10:37:56 -0300
Subject: [PATCH] ARM: mx25: fix missing common.h include
In-Reply-To: <1465473998-32261-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465473998-32261-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAOMZO5BF_wh8djGev+bz5v815v0ei3hc+sPD30Y7cVdnNU-WoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 9, 2016 at 9:06 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> The prototype for imx25_pm_init() was not in any of the included
> headers, so add common.h where it is declared to remove the
> following warning:
>
> arch/arm/mach-imx/pm-imx25.c:34:13: warning: symbol 'imx25_pm_init' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks for the patch:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
