From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 16:50:01 +0200
Subject: [PATCH V2 3/4] ARM64 LPC: support serial based on low-pin-count
In-Reply-To: <1473255233-154297-4-git-send-email-yuanzhichang@hisilicon.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473255233-154297-4-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <5345060.9D0B4ujt5e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 9:33:52 PM CEST Zhichang Yuan wrote:
> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> 
> On Hip06 platform, a 16550 compatible UART is connected to low-pin-count and
> controlled through the LPC I/O cycles. This patch drives the UART port with
> the specific serial in/out function pair based on the indirect-IO mechanism
> introduced by Hip06 LPC driver.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>

Any reason this cannot just use the regular drivers/tty/serial/8250/8250_of.c
driver?

	Arnd
