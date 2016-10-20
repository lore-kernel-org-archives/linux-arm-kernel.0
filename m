From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 15:00:56 +0200
Subject: [PATCH v2 1/8] drm/bridge: rgb-to-vga: Support an enable GPIO
In-Reply-To: <20161020034344.14154-2-wens@csie.org>
References: <20161020034344.14154-1-wens@csie.org>
 <20161020034344.14154-2-wens@csie.org>
Message-ID: <20161020130056.6tf4uuqsxiphqzx4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 11:43:37AM +0800, Chen-Yu Tsai wrote:
> Some rgb-to-vga bridges have an enable GPIO, either directly tied to
> an enable pin on the bridge IC, or indirectly controlling a power
> switch.
> 
> Add support for it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/5175074f/attachment-0001.sig>
