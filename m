From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 2 Feb 2012 13:29:52 -0700 (MST)
Subject: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
In-Reply-To: <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
 <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Feb 2012, Paul Walmsley wrote:

> Great.  Do you know what the deal is with suspend on 34xx?  I enabled 
> ttyO2 wakeup and entered suspend, but serial traffic doesn't bring it out?

Just a quick followup; Kevin tracked this down.  v3.3-rc needs the MTD 
suspend patch that Artem posted recently to suspend correctly on OMAP35xx 
BeagleBoard with omap2plus_defconfig.  Thanks Kevin.


- Paul
