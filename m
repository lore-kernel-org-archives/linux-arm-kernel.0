From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Mar 2017 09:13:03 +0200
Subject: [PATCH 2/2] ARM: dts: sun5i: Add interrupt for display backend
In-Reply-To: <20170327143847.16259-3-wens@csie.org>
References: <20170327143847.16259-1-wens@csie.org>
 <20170327143847.16259-3-wens@csie.org>
Message-ID: <20170329071303.ft7oukmhczihy2xb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 10:38:47PM +0800, Chen-Yu Tsai wrote:
> The display backend on sun5i shares the same interrupt line as the
> display frontend. Add it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

And ideally, patches prefix shouldn't have dts here too. I've dropped
it and applied, thanks!

> This won't directly apply to old releases. We may want to backport
> them though?

Yep, probably. Do you want to send it to stable?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170329/fd517d70/attachment.sig>
