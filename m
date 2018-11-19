From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Nov 2018 09:34:36 +0100
Subject: [PATCH v2 05/12] drm/sun4i: tcon: Export get tcon0 routine
In-Reply-To: <20181116163916.29621-6-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-6-jagan@amarulasolutions.com>
Message-ID: <20181119083436.pbwl4djcvvmsefrw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 10:09:09PM +0530, Jagan Teki wrote:
> Sometimes tcon attributes like tcon divider, clock rate etc are
> needed in interface drivers like DSI. So for such cases interface
> driver must probe the respective tcon and get the attributes.
> Instead of probing tcon explictly, better export the existing
> sun5i_get_tcon0 so-that the relevant interface can reuse.

That's not the name of the function you export.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181119/13d12f45/attachment.sig>
