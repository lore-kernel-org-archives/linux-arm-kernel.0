From: jani.nikula@linux.intel.com (Jani Nikula)
Date: Thu, 09 Nov 2017 14:12:45 +0200
Subject: [PATCH] drm/bridge: dw-hdmi: fix EDID parsing
In-Reply-To: <CAEzXK1qx=frs=Py3FhUK2vCfEp3Uzt2Nt=hKyxOnaP-nj4z8HA@mail.gmail.com>
References: <E1eC22L-0003sN-Dw@rmk-PC.armlinux.org.uk>
 <20171109082317.predibr5vv2d33i2@phenom.ffwll.local>
 <20171109093122.GA12318@n2100.armlinux.org.uk> <87inejaiij.fsf@intel.com>
 <CAEzXK1qHEcB6f_uGPJk9RxSd+tP5rNuiutBN1FAkEv-nU1k5Ug@mail.gmail.com>
 <CAEzXK1qx=frs=Py3FhUK2vCfEp3Uzt2Nt=hKyxOnaP-nj4z8HA@mail.gmail.com>
Message-ID: <87efp7abwi.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 09 Nov 2017, Lu?s Mendes <luis.p.mendes@gmail.com> wrote:
> I've just applied the referred individual patch to kernel-4.14-rc5 and
> the EDID isn't loaded. dw-hdmi gets no firmware at all.

Sorry, I didn't mean you could just cherry-pick that one commit and make
it work. There were a number of preparatory patches before that, and I
think some cleanups on top.

Please try drm-next to make sure you have it all.

We didn't intend for the commits to be backported, instead we very much
wanted them to get a gradually increasing amount of exposure first to
make sure we don't break stuff.

And as I said elsewhere in the thread, Russell's patch may be relevant
for current Linus' master and stable. We just need to reconciliate how
the two things should work together in drm-next and v4.15 and on.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
