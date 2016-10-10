From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Oct 2016 10:31:24 +0200
Subject: [PATCH v6 1/5] drm/sun4i: rgb: Remove the bridge enable/disable
 functions
In-Reply-To: <CAOw6vbJ5C95rxK6--zEintO=qeu+Pm=OcvB+SYzQuvz5pSQaaw@mail.gmail.com>
References: <cover.2ec28e2292f37131839babc08427ef9f1aece26a.1475740611.git-series.maxime.ripard@free-electrons.com>
 <5100ee37c9bbb53f8227bd38f1d3160e507c489d.1475740611.git-series.maxime.ripard@free-electrons.com>
 <CAOw6vbJ5C95rxK6--zEintO=qeu+Pm=OcvB+SYzQuvz5pSQaaw@mail.gmail.com>
Message-ID: <20161010083124.GB3462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2016 at 03:43:21PM -0400, Sean Paul wrote:
> On Thu, Oct 6, 2016 at 3:57 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The atomic helpers already call the drm_bridge_enable on our behalf,
> > there's no need to do it a second time.
> >
> > Reported-by: Sean Paul <seanpaul@chromium.org>
> 
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

Thanks, I just queued it in my fixes for 4.9.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161010/65bef188/attachment.sig>
