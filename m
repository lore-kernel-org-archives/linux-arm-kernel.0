From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Mar 2014 20:03:18 +0800
Subject: [PATCH] ARM: i.MX: mx21ads: Replace direct handling of
 peripheral bits with GPIOs
In-Reply-To: <1393871864-25223-1-git-send-email-shc_work@mail.ru>
References: <1393871864-25223-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140305120313.GO8784@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 10:37:44PM +0400, Alexander Shiyan wrote:
> This patch replaces direct handling of peripheral bits with GPIOs by
> using basic-mmio-gpio driver. As a result this change eliminate some
> low-level code and removes custom io_map() from the board.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.
