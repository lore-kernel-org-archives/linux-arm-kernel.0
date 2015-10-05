From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Oct 2015 00:02:37 +0200
Subject: [PATCH v2 2/2] irqchip: sunxi-nmi: switch to
 of_io_request_and_map() from of_iomap()
In-Reply-To: <1444063334-19832-3-git-send-email-wens@csie.org>
References: <1444063334-19832-1-git-send-email-wens@csie.org>
 <1444063334-19832-3-git-send-email-wens@csie.org>
Message-ID: <20151005220237.GO2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 12:42:14AM +0800, Chen-Yu Tsai wrote:
> Switch to the new of_io_request_and_map() call, so the IO resource is
> properly held, and also shows up in /proc/iomem.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/22863f84/attachment.sig>
