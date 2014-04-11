From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Apr 2014 15:06:17 +0200
Subject: [PATCH v3 2/7] pinctrl: sunxi: disable clk when failing to probe
 pin controller
In-Reply-To: <1397137966-30818-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397137966-30818-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140411130617.GY28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 03:52:41PM +0200, Boris BREZILLON wrote:
> Disable the clk when failing to probe the pin controller device.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/6ee41605/attachment.sig>
