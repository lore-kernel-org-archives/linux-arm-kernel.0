From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Jan 2015 00:10:07 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <alpine.LFD.2.11.1501271614280.1322@knanqh.ubzr>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20150127132127.GA869@amd>
 <CAL_JsqKM+2PtX_EpWXyOQHVXwf=jqVj8SroUGPO1Y2=Zj8_kMg@mail.gmail.com>
 <201501271532.25540@pali>
 <20150127174818.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501271446330.1322@knanqh.ubzr>
 <20150127210943.GN26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501271614280.1322@knanqh.ubzr>
Message-ID: <20150127231007.GA27641@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Useful when properly designed and generic enough to be shared.
> > > 
> > > I'd suggest a DT property be proposed for that purpose if it doesn't 
> > > already exist.  That at least has a chance to be generically useful.
> > 
> > What this means is that we have to further augment the atags-to-dt code
> > in the decompressor with the platform specific ATAGs to parse this
> > information and merge it into the appended DT before passing the
> > resulting DT blob to the kernel.
> 
> That would be only 2 new lines of code in the best case.

Yes, instead of 2 new lines of code, let people write, debug, and
flash 1000 lines shim. Completely makes sense.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
