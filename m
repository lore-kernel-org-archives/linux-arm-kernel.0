From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 09 Mar 2012 09:55:00 +0200
Subject: [PATCH] ARM: OMAP2+: Fix compile error when FB_OMAP2 is not set
In-Reply-To: <20120308204328.GW12083@atomide.com>
References: <20120308204328.GW12083@atomide.com>
Message-ID: <1331279700.1927.1.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-03-08 at 12:43 -0800, Tony Lindgren wrote:
> Otherwise we will get:
> 
> arch/arm/plat-omap/fb.c:101: error: expected ?)? before ?*? token
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks. It seems I need to improve my testing practices to include
non-FB builds also...

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/499205b3/attachment-0001.sig>
