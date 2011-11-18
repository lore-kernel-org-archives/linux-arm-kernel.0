From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Nov 2011 17:49:34 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1321618849.24216.323.camel@hornet.cambridge.arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111116154402.GE2073@localhost.localdomain> <4EC3E446.4030608@gmail.com>
 <1321461458.3137.374.camel@hornet.cambridge.arm.com>
 <4EC3EBEC.3020601@gmail.com>
 <1321463271.3137.380.camel@hornet.cambridge.arm.com>
 <20111117155334.GT9581@n2100.arm.linux.org.uk>
 <1321618849.24216.323.camel@hornet.cambridge.arm.com>
Message-ID: <20111118174934.GH9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 12:20:49PM +0000, Pawel Moll wrote:
> On Thu, 2011-11-17 at 15:53 +0000, Russell King - ARM Linux wrote:
> > Again, this is _not_ how DT is supposed to work.  DT is about describing
> > the hardware, not describing the state of something.  
> 
> And that's exactly what I was trying to do. Describe the hardware, using
> terminology *used by the hardware designers* - fact that you have chosen
> to ignore, fair enough.

Again, you're totally FAILING to get the point.

Had DT support been created before the new version came out there would
be no 'legacy' in terminology what so ever.  _That's_ the whole point.

What you're using is *todays* terminology, not the terminology used at
the point of *creation*.

Why can't you get it through your thick skull that at some day, the
entire Cortex-A5 series of CPUs is going to be called 'legacy'.  And
at that point, will you be wanting to rename all the properties because
of that change?  No.  That's insane.  So why the fuck do it now to the
CA9x5?

Try thinking.  It's good for the mind.
