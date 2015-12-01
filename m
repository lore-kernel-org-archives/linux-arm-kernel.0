From: horms@verge.net.au (Simon Horman)
Date: Tue, 1 Dec 2015 15:44:35 +0900
Subject: [PATCH] ARM: shmobile: defconfig: Enable CONFIG_PRINTK_TIME
In-Reply-To: <1448890534-1430-1-git-send-email-geert+renesas@glider.be>
References: <1448890534-1430-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20151201064434.GI16260@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 02:35:34PM +0100, Geert Uytterhoeven wrote:
> Enable timestamps for kernel log output to improve debugging.
> You can always use "dmesg -t" to strip the timestamps.
> 
> Don't specify CONFIG_LOG_BUF_SHIFT=16 while we're at it.  There's a
> reason the default in Kconfig is higher ;-)
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
