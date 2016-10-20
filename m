From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 18:02:41 +0200
Subject: [PATCH v2 8/8] ARM: dts: sun6i: hummingbird-a31: Enable display
 output through VGA bridge
In-Reply-To: <20161020034344.14154-9-wens@csie.org>
References: <20161020034344.14154-1-wens@csie.org>
 <20161020034344.14154-9-wens@csie.org>
Message-ID: <20161020160241.vazi2afm47rky4fi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;4402;0c
On Thu, Oct 20, 2016 at 11:43:44AM +0800, Chen-Yu Tsai wrote:
> The Hummingbird A31 board has a RGB-to-VGA bridge which converts RGB
> output from the LCD interface to VGA signals.
> 
> Enable this part of the display pipeline.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

This one looks nice, but I'm going to wait for Archit answers before
merging it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/ea5a402d/attachment.sig>
