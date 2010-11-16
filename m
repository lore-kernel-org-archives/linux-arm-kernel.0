From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 16 Nov 2010 09:48:18 -0700 (MST)
Subject: [PATCH 0/3] OMAP: wd_timer: update integration code to use new
	hwmod changes
In-Reply-To: <20101116102205.27991.37909.stgit@twilight.localdomain>
References: <20101116102205.27991.37909.stgit@twilight.localdomain>
Message-ID: <alpine.DEB.2.00.1011160947330.32653@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Nov 2010, Paul Walmsley wrote:

> Update the OMAP watchdog timer integration code to take advantage of
> the new hwmod upgrades added by the "OMAP2+: hwmod core upgrades for
> 2.6.38: first set" series, posted previously.  So that series needs
> to be applied before these patches.
> 
> Charu, it would be great if you could take a look at these.
> 
> Tested on an OMAP34xx BeagleBoard with omap2plus_defconfig.

And these patches are also available as 'wdt_2.6.38' from 
git://git.pwsan.com/linux-2.6


- Paul
