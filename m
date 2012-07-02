From: b32955@freescale.com (Huang Shijie)
Date: Mon, 2 Jul 2012 10:48:37 +0800
Subject: [PATCH v3 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <1341200327-8144-4-git-send-email-shijie8@gmail.com>
References: <1341200327-8144-1-git-send-email-shijie8@gmail.com>
 <1341200327-8144-4-git-send-email-shijie8@gmail.com>
Message-ID: <4FF10C05.70306@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?07?02? 11:38, Huang Shijie ??:
> -			status = "disabled"; /* gpmi nand conflicts with SD */
> +			status = "okay"; /* gpmi nand conflicts with SD */
>   		};
sorry, this is my mistake.

I will fix it in the next version.
But you can give your comments about other code of this patch.

thanks.

Huang Shijie
