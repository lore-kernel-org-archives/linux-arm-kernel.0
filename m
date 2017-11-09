From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Nov 2017 16:26:35 +0000
Subject: [PATCH] drm/bridge: dw-hdmi: fix EDID parsing
In-Reply-To: <87efp7abwi.fsf@intel.com>
References: <E1eC22L-0003sN-Dw@rmk-PC.armlinux.org.uk>
 <20171109082317.predibr5vv2d33i2@phenom.ffwll.local>
 <20171109093122.GA12318@n2100.armlinux.org.uk>
 <87inejaiij.fsf@intel.com>
 <CAEzXK1qHEcB6f_uGPJk9RxSd+tP5rNuiutBN1FAkEv-nU1k5Ug@mail.gmail.com>
 <CAEzXK1qx=frs=Py3FhUK2vCfEp3Uzt2Nt=hKyxOnaP-nj4z8HA@mail.gmail.com>
 <87efp7abwi.fsf@intel.com>
Message-ID: <20171109162634.GC12318@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 02:12:45PM +0200, Jani Nikula wrote:
> And as I said elsewhere in the thread, Russell's patch may be relevant
> for current Linus' master and stable. We just need to reconciliate how
> the two things should work together in drm-next and v4.15 and on.

Exactly, the patch is intended for current kernels.  The hint is that
(a) it's a bug fix, (b) it says "fix" in the title, and (c) it has the
stable attributation which says "apply me to previous kernels".

Daniel's response effectively says "no, we're not going to accept the
patch, work on a fix with some development code."

So, unless someone wants to tell me that it's acceptable to develop bug
fixes against Linus' tree _for_ Linus' tree and accept this patch, or
show some other solution that can be applied to Linus' current tree and
backported to stable trees, I'm just not going to bother in future -
someone else can end up doing the work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
