From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 14:03:52 +0100
Subject: [PATCH 4/9] clk: Add clock driver for mb86s7x
In-Reply-To: <1416486975-25385-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416486975-25385-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <2396055.pBuh1YtUHT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 20:36:15 Vincent Yang wrote:
> +#define __DTS_MB86S70_CLK_H
> +
> +#define MB86S70_CRG11_ALW      0
> +#define MB86S70_CRG11_DDR3     1
> +#define MB86S70_CRG11_MAIN     2
> +#define MB86S70_CRG11_CA15     3
> +#define MB86S70_CRG11_HDMI     4
> +#define MB86S70_CRG11_DPHY     5
> +
> +#define MB86S70_CRG11_UNGPRT   8
> 

The clock driver doesn't seem to use those macros at all, how does the
driver know which clock you are referring to?

	Arnd
