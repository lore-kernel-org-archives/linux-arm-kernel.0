From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 11 Feb 2014 10:53:11 -0300
Subject: [PATCH 0/2] Marvell Armada 375 and 38x timer support
In-Reply-To: <52FA20EF.30807@linaro.org>
References: <1392059274-26965-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <52FA1FBD.90906@linaro.org>
 <20140211130758.GX8533@titan.lakedaemon.net>
 <52FA20EF.30807@linaro.org>
Message-ID: <20140211135310.GA23150@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Tue, Feb 11, 2014 at 02:09:03PM +0100, Daniel Lezcano wrote:
> >>
> >> Applied to my tree for 3.15.
> >
> > Please hold off until we've resolved the discussion regarding adding
> > unneeded compatible strings.  It's under patch 6 in the main series
> > adding support for this new SoC.
> >

Yes, please drop it for now.

> >    [PATCH 06/11] ARM: mvebu: add Armada 380/385 support to the system-controller driver
> 
> Ok, thanks for the heads up.
> 

Ah, my bad! I should have added a warning about the discussion as I did
for the MBus patches. See:

http://www.spinics.net/lists/arm-kernel/msg306480.html

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
