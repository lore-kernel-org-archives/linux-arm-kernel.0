From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Oct 2015 19:22:54 +0100
Subject: [PATCH v4] twd: Don't set CLOCK_EVT_FEAT_C3STOP unconditionally
In-Reply-To: <5616B2F8.3010602@free.fr>
References: <56123BD0.8010005@sigmadesigns.com>
 <56124035.6080107@sigmadesigns.com>
 <CACRpkdbWRU3UH6aJnqdcuzdh_-sE7ryhs0vBTUbbRDcJ7PWXLw@mail.gmail.com>
 <561247DF.1000308@sigmadesigns.com>
 <20151005103539.GC19064@leverpostej>
 <5612649C.5020401@sigmadesigns.com>
 <20151008171616.GG7275@leverpostej> <5616AA2D.2070101@free.fr>
 <20151008174333.GI32532@n2100.arm.linux.org.uk>
 <5616B2F8.3010602@free.fr>
Message-ID: <20151008182254.GJ32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 08:16:24PM +0200, Mason wrote:
> On 08/10/2015 19:43, Russell King - ARM Linux wrote:
> > On Thu, Oct 08, 2015 at 07:38:53PM +0200, Mason wrote:
> >> On 08/10/2015 19:16, Mark Rutland wrote:
> >>> Otherwise this looks ok. If you can respin with the above wording, and
> >>> s/twd-never-stops/always-on/ in the patch, you can add:
> >>>
> >>> Acked-by: Mark Rutland <mark.rutland@arm.com>
> >>
> >> Wouldn't you feel like going all-in and Signing-off? ;-)
> > 
> > Then I'd reject it, because it would be wrong.
> > 
> > Documentation/SubmittingPatches: [snip]
> 
> Could someone explain the difference between Acked-by and
> Reviewed-by?

Again, I could quote from the above file, but you already have a copy
of it locally, so you could just read that version instead.  Section 13.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
