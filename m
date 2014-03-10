From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Mar 2014 13:08:55 +0800
Subject: [PATCH 1/2] ARM: i.MX: mx21ads: Use fixed voltage regulator for
 LCD power
In-Reply-To: <1394123013-28562-1-git-send-email-shc_work@mail.ru>
References: <1394123013-28562-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140310050853.GD15218@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 08:23:32PM +0400, Alexander Shiyan wrote:
> Instead of using init() and exit() hooks from framebuffer driver
> to control power of LCD, introduce fixed voltage regulator for
> this purpose.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied both, thanks.
