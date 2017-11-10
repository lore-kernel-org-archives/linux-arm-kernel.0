From: jani.nikula@linux.intel.com (Jani Nikula)
Date: Fri, 10 Nov 2017 11:45:27 +0200
Subject: [PATCH] drm/bridge: dw-hdmi: fix EDID parsing
In-Reply-To: <20171109162634.GC12318@n2100.armlinux.org.uk>
References: <E1eC22L-0003sN-Dw@rmk-PC.armlinux.org.uk>
 <20171109082317.predibr5vv2d33i2@phenom.ffwll.local>
 <20171109093122.GA12318@n2100.armlinux.org.uk> <87inejaiij.fsf@intel.com>
 <CAEzXK1qHEcB6f_uGPJk9RxSd+tP5rNuiutBN1FAkEv-nU1k5Ug@mail.gmail.com>
 <CAEzXK1qx=frs=Py3FhUK2vCfEp3Uzt2Nt=hKyxOnaP-nj4z8HA@mail.gmail.com>
 <87efp7abwi.fsf@intel.com> <20171109162634.GC12318@n2100.armlinux.org.uk>
Message-ID: <87zi7u8o20.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 09 Nov 2017, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> On Thu, Nov 09, 2017 at 02:12:45PM +0200, Jani Nikula wrote:
>> And as I said elsewhere in the thread, Russell's patch may be relevant
>> for current Linus' master and stable. We just need to reconciliate how
>> the two things should work together in drm-next and v4.15 and on.
>
> Exactly, the patch is intended for current kernels.  The hint is that
> (a) it's a bug fix, (b) it says "fix" in the title, and (c) it has the
> stable attributation which says "apply me to previous kernels".
>
> Daniel's response effectively says "no, we're not going to accept the
> patch, work on a fix with some development code."

Please don't turn a technical discussion into an unnecessary
altercation. Focusing on finding the best solution instead would be much
appreciated.

> So, unless someone wants to tell me that it's acceptable to develop bug
> fixes against Linus' tree _for_ Linus' tree and accept this patch, or
> show some other solution that can be applied to Linus' current tree and
> backported to stable trees, I'm just not going to bother in future -
> someone else can end up doing the work.

I also don't want non-regression fixes merged to Linus' tree if they're
known to regress much wider impact work queued to Linus' tree for the
next merge window. And it's not just some development code, it's been in
drm-next and linux-next for more than 1? months now. So I want to figure
this out first.

Lu?s, can you try try drm-next *with* Russell's patch, please?


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
