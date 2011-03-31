From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 31 Mar 2011 12:49:57 +0300
Subject: [PATCH 5/7] add GPMI support for imx28
In-Reply-To: <1300240521-4344-6-git-send-email-b32955@freescale.com>
References: <1300240521-4344-1-git-send-email-b32955@freescale.com>
	<1300240521-4344-6-git-send-email-b32955@freescale.com>
Message-ID: <1301564997.2828.28.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-16 at 09:55 +0800, Huang Shijie wrote:
> +       .description               = "Single-chip boot area, "
> +                                               "block mark swapping
> supported", 

Because you love tabs so much, you have to do this strange splitting of
strings. Just use normal spaces and you'll fit many things in one line.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
