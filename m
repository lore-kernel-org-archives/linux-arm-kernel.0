From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 30 Sep 2011 23:53:40 +0800
Subject: [PATCH] ARM: mxs: Consolidate mm-mx23.c and mm-mx28.c into a
	single file
In-Reply-To: <1317385328-14529-1-git-send-email-fabio.estevam@freescale.com>
References: <1317385328-14529-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110930155338.GI19807@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 09:22:08AM -0300, Fabio Estevam wrote:
> Consolidate mm-mx23.c and mm-mx28.c into a single file.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mxs/Makefile  |    6 ++--
>  arch/arm/mach-mxs/mm-mx23.c |   44 ------------------------------
>  arch/arm/mach-mxs/mm-mx28.c |   44 ------------------------------
>  arch/arm/mach-mxs/mm-mxs.c  |   63 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 91 deletions(-)
>  delete mode 100644 arch/arm/mach-mxs/mm-mx23.c
>  delete mode 100644 arch/arm/mach-mxs/mm-mx28.c
>  create mode 100644 arch/arm/mach-mxs/mm-mxs.c

I do not see the need of '-mxs' suffix.

-- 
Regards,
Shawn
