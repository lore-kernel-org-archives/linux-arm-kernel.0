From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Mar 2015 21:58:30 +0100
Subject: [PATCH V6] kbuild: dtbs_install: new make target
In-Reply-To: <CAOesGMh4Xyyn5mDDo5_88pvZgdVJ-33UYvm8Y_9UNALfsqrytg@mail.gmail.com>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1385942188-21831-1-git-send-email-jason@lakedaemon.net>
 <20150328132320.GA24391@n2100.arm.linux.org.uk>
 <20150328155822.GA25778@io.lakedaemon.net>
 <CAOesGMh4Xyyn5mDDo5_88pvZgdVJ-33UYvm8Y_9UNALfsqrytg@mail.gmail.com>
Message-ID: <20150329205829.GC24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 29, 2015 at 01:34:41PM -0700, Olof Johansson wrote:
> On Sat, Mar 28, 2015 at 8:58 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > Russell,
> >
> > On Sat, Mar 28, 2015 at 01:23:20PM +0000, Russell King - ARM Linux wrote:
> >> Okay, I'm digging up an old version of this patch - v7 was merged but
> >> I find *nowhere* where that version was posted to people involved in
> >> this discussion.
> >
> > fwiw, I just went through my archive of patch submissions:
> >
> > $ ls ~/projects/linux/dtbs_install/
> > v2  v3  v4  v5  v6
> > $
> >
> > I never wrote a v7.  :-(  Regardless,
> 
> It was posted by Grant, and posted to LKML, devicetree@ and
> linux-kbuild. The patch was directly cc:d to Jason, Michal Marek,
> Russell and Rob Herring.

I couldn't find a copy of it - grepping for "^Subject:.*dtb.*install"
around December 2013 and before only found Jason's original patches.

The commit introducing it says:

commit f4d4ffc03efc864645b990e1d579bbe1b8e358a4
Author:     Jason Cooper <jason@lakedaemon.net>
AuthorDate: Sun Dec 1 23:56:28 2013 +0000
Commit:     Grant Likely <grant.likely@linaro.org>
CommitDate: Thu Feb 20 15:53:39 2014 +0000

    kbuild: dtbs_install: new make target

So it seems that I was looking at the wrong date range... Grant did
send the patch on the 4th February, which I never got around to
reading.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
