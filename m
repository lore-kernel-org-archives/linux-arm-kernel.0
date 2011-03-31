From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 31 Mar 2011 12:47:29 +0300
Subject: [PATCH 5/7] add GPMI support for imx28
In-Reply-To: <1300240521-4344-6-git-send-email-b32955@freescale.com>
References: <1300240521-4344-1-git-send-email-b32955@freescale.com>
	<1300240521-4344-6-git-send-email-b32955@freescale.com>
Message-ID: <1301564849.2828.26.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-16 at 09:55 +0800, Huang Shijie wrote:
> +#define BF_BCH_CTRL_RSVD5(v)  \
> +               (((v) << 23) & BM_BCH_CTRL_RSVD5) 

Many lines where you used "\" fit 80 lines. Just do not use tabs between
name and value (which is ugly, imo), use a space and then it fits 80
lines. This neater than splitting things on 2 lines.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
