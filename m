From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Mon, 21 Jun 2010 17:36:29 +0200
Subject: [PATCH 07/12] arm: remove duplicated #include
In-Reply-To: <1274548354-2088-1-git-send-email-weiyi.huang@gmail.com>
References: <1274548354-2088-1-git-send-email-weiyi.huang@gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025E8B03A7@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Huang]
> From: Huang Weiyi [mailto:weiyi.huang at gmail.com]
> Sent: den 22 maj 2010 19:13
> To: Linus WALLEIJ
> Cc: linux-arm-kernel at lists.infradead.org; Huang Weiyi
> Subject: [PATCH 07/12] arm: remove duplicated #include
> 
> Remove duplicated #include('s) in
>   arch/arm/plat-nomadik/include/plat/ste_dma40.h
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

But you have to send the patch to the DMAengine subsystem maintainer
Dan Williams.

Linus Walleij
