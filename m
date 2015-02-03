From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 3 Feb 2015 08:50:11 +0100
Subject: [RFCv3 2/2] dma-buf: add helpers for sharing attacher
 constraints with dma-parms
In-Reply-To: <CAF6AEGvE78a9u9=C6HbuuYs_zwGf6opdXUNfxb51kixFa7zLwA@mail.gmail.com>
References: <20150129143908.GA26493@n2100.arm.linux.org.uk>
 <CAO_48GEOQ1pBwirgEWeVVXW-iOmaC=Xerr2VyYYz9t1QDXgVsw@mail.gmail.com>
 <20150129154718.GB26493@n2100.arm.linux.org.uk>
 <CAF6AEGtTmFg66TK_AFkQ-xp7Nd9Evk3nqe6xCBp7K=77OmXTxA@mail.gmail.com>
 <20150129192610.GE26493@n2100.arm.linux.org.uk>
 <CAF6AEGujk8UC4X6T=yhTrz1s+SyZUQ=m05h_WcxLDGZU6bydbw@mail.gmail.com>
 <20150202165405.GX14009@phenom.ffwll.local>
 <CAF6AEGuESM+e3HSRGM6zLqrp8kqRLGUYvA3KKECdm7m-nt0M=Q@mail.gmail.com>
 <20150202214616.GI8656@n2100.arm.linux.org.uk>
 <CAF6AEGvE78a9u9=C6HbuuYs_zwGf6opdXUNfxb51kixFa7zLwA@mail.gmail.com>
Message-ID: <20150203075011.GG14009@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 05:36:10PM -0500, Rob Clark wrote:
> well, I guess anyways when it comes to sharing buffers, it won't be
> the vram placement of the bo that gets shared ;-)

Actually that's pretty much what I'd like to be able to do for i915.
Except that vram is just a specially protected chunk of main memory.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
