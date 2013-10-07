From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 7 Oct 2013 11:01:41 +0200
Subject: [PATCH 3/5] DRM: Armada: Add support for ARGB 32x64 or 64x32
 hardware cursors
In-Reply-To: <E1VSwWS-0000i7-4f@rmk-PC.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwWS-0000i7-4f@rmk-PC.arm.linux.org.uk>
Message-ID: <20131007110141.27f1ac25@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 06 Oct 2013 23:09:56 +0100
Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> This patch adds ARGB hardware cursor support to the DRM driver for the
> Marvell Armada SoCs.  ARGB cursors are supported at either 32x64 or
> 64x32 resolutions.
	[snip]

I don't see the interest of such cursors. Actually, most often, the
cursors are 64x64 and 'A' is either 0 or 0xff. As the Armada 510
supports 64x64 cursors with transparency, it would be more useful to
implement these ones...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
