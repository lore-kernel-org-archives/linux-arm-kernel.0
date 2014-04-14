From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 18:01:42 +0200
Subject: [PATCH v2 0/5] Support for Marvell AHCI interface on Armada 38x
In-Reply-To: <16639486.i0jTGsaDYr@amdc1032>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <16639486.i0jTGsaDYr@amdc1032>
Message-ID: <20140414180142.0dd63a1f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bartlomiej Zolnierkiewicz,

On Mon, 14 Apr 2014 17:53:37 +0200, Bartlomiej Zolnierkiewicz wrote:

> >  * Fixed the module alias name. Suggested by Bartlomiej
> >    Zolnierkiewicz.
> 
> Well, you could have also added a comment explaining the lack of
> the Power Management support..

True, sorry for this. Should I resend a new version of the patch series
with an indication about this in the commit log? Or is this OK as it is?

Note that working on power management support is part of our mid-term
TODO list for this platform, so it will not remain unimplemented
forever.

> Anyway, all patches look OK to me.
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
