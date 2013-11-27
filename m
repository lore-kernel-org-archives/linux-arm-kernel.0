From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Wed, 27 Nov 2013 22:57:04 +0200
Subject: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on
 device id
In-Reply-To: <87ioveeo0x.fsf@octavius.laptop.org>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-3-git-send-email-tony@atomide.com>
 <20131118184723.GR10317@atomide.com>
 <87ioveeo0x.fsf@octavius.laptop.org>
Message-ID: <20131127225704.208445df2aa7fc5fc6cb5faa@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris

On Tue, 26 Nov 2013 18:33:50 -0500
Chris Ball <cjb@laptop.org> wrote:

> Hi Tony,
> 
> On Mon, Nov 18 2013, Tony Lindgren wrote:
> > We are wrongly relying on device id for the DMA configuration
> > which can lead to wrong DMA channel being selected.
> >
> > Fix the issue by using the standard resources like we should.
> >
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc at vger.kernel.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Feel free to merge via your tree:
> 
> Acked-by: Chris Ball <cjb@laptop.org>
> 
Can you enlighten me what's the proper way to get patches to mmc since
I cannot figure out working methodology from MAINTAINERS file?

I happened to notice that Tony had this similar patch in linux-omap
list I sent first time already September to you and linux-mmc (sorry
linux-omap folks, I didn't want to spam multiple lists):

http://www.spinics.net/lists/linux-mmc/msg22137.html

After that I've resend the set a few times including a fix to
user triggable NULL pointer dereference:

http://www.spinics.net/lists/linux-mmc/msg22610.html

I'm fine if mmc patches should go through other subsystems but at least
it should be documented in MAINTAINERS file.

-- 
Jarkko
