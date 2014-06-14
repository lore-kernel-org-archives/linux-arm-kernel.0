From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 14 Jun 2014 22:33:56 +0200
Subject: [PATCH] ARM: zImage: Allow DTB to override broken ATAG_MEM
In-Reply-To: <536AA482.8040506@suse.de>
References: <1399439776-18535-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20140507080650.GA28564@pengutronix.de>
 <CAJAp7OiVrz+epys3Ko79GmMr6ahv8ii8XphVHE77NSM+wK2mOA@mail.gmail.com>
 <536AA482.8040506@suse.de>
Message-ID: <20140614203356.GD3853@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2014-05-07 23:24:18, Andreas F?rber wrote:
> Am 07.05.2014 17:29, schrieb Bjorn Andersson:
> > My problem is that the boot loader on every shipped Qualcomm MSM8x60, MSM8960
> > and APQ8064 based device passes ATAG_MEM with the incorrect start address. There
> > is no way to update the boot loader for these.
> 
> Chaining bootloaders comes to mind. This is being done on the Exynos5
> based Chromebooks, for instance.

You can easily start fixed u-boot from broken u-boot...

But I'm not sure that's the way to go. Perhaps your localised/ugly hack in board
init code is the way to go...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
