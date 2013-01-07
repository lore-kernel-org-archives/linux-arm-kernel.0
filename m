From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Jan 2013 08:12:49 +0000 (UTC)
Subject: [PATCH 2/3] ARM: OMAP4: hwmod data: do not enable or reset the
 AESS during kernel init
In-Reply-To: <50E73B3D.4010705@ti.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com>
 <1357304526-21557-3-git-send-email-s-guiriec@ti.com>
 <alpine.DEB.2.00.1301041833510.25868@utopia.booyaka.com>
 <50E73B3D.4010705@ti.com>
Message-ID: <alpine.DEB.2.00.1301070811140.2177@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 4 Jan 2013, Sebastien Guiriec wrote:

> Paul,
> Do you want me to rebase this version and update the serie or are you handle
> it?

Sure, it would be great if you could take this over and test it and 
repost.

You might find the 'aess_reset_devel_3.9' branch at 
git://git.pwsan.com/linux-2.6 useful.  It's a forward port of some of the 
3.5-rc work.  It's only compile-tested, so you might need to tweak it to 
get it to work.


- Paul
