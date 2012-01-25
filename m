From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 25 Jan 2012 14:26:05 -0700 (MST)
Subject: [GIT PULL] ARM: OMAP: hwmod/PRCM/OMAP2xxx fixes for 3.3
In-Reply-To: <alpine.DEB.2.00.1201251420490.5324@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201251420490.5324@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1201251425080.5324@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jan 2012, Paul Walmsley wrote:

> The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
> 
>   Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 omap_fixes_a_3.3rc

By the way, since Beno?t had already sent a fix for the OMAP1/2xxx I2C 
build bug, I dropped my fix from this series.  So this patch is still 
required before OMAP1/2xxx will build:

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg61520.html


- Paul
