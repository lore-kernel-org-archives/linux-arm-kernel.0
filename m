From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 6 Jun 2017 20:39:33 +0200
Subject: [PATCH v2 3/4] net: macb: macb.c changed to macb_main.c
In-Reply-To: <1496413661-21452-1-git-send-email-rafalo@cadence.com>
References: <1496413439-12900-1-git-send-email-rafalo@cadence.com>
 <1496413661-21452-1-git-send-email-rafalo@cadence.com>
Message-ID: <20170606183933.GA1205@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 03:27:41PM +0100, Rafal Ozieblo wrote:
>  drivers/net/ethernet/cadence/macb.c      | 3568 ------------------------------
>  drivers/net/ethernet/cadence/macb_main.c | 3568 ++++++++++++++++++++++++++++++

You deleted macb.c, and so ...

> diff --git a/drivers/net/ethernet/cadence/Makefile b/drivers/net/ethernet/cadence/Makefile
> index 4ba7559..31ea6e3 100644
> --- a/drivers/net/ethernet/cadence/Makefile
> +++ b/drivers/net/ethernet/cadence/Makefile
> @@ -1,6 +1,7 @@
>  #
>  # Makefile for the Atmel network device drivers.
>  #
> +macb-y	:= macb_main.o
>  
>  obj-$(CONFIG_MACB) += macb.o

how does this rule make sense any more?

Thanks,
Richard
