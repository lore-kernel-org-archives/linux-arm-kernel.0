From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 01 Apr 2011 17:20:12 +0300
Subject: [PATCH] MTD: atmel_nand: Fall back to CPU I/O when buffer is
	in vmalloc(ed) region
In-Reply-To: <1301567595-31075-1-git-send-email-hong.xu@atmel.com>
References: <1301567595-31075-1-git-send-email-hong.xu@atmel.com>
Message-ID: <1301667612.2789.86.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-31 at 18:33 +0800, Hong Xu wrote:
> The previous way of dealing with vmalloc(ed) region by walking though the pages can not work well actually.
> We just fall back to CPU I/O when the buffer address is higher than `high_memory'.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Hong Xu <hong.xu@atmel.com>

Pushed to l2-mtd-2.6.git, thanks!

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
