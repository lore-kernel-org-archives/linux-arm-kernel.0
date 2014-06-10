From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 10 Jun 2014 02:15:16 +0200
Subject: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
In-Reply-To: <20140609225142.GA5099@sirena.org.uk>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
 <1976508.Da0u8DZI5B@vostro.rjw.lan> <20140609225142.GA5099@sirena.org.uk>
Message-ID: <1857766.e38RV3V2OT@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 09, 2014 11:51:42 PM Mark Brown wrote:
> 
> --fYgRtaZIy+F1uhp1
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Tue, Jun 10, 2014 at 12:22:07AM +0200, Rafael J. Wysocki wrote:
> > On Monday, June 09, 2014 08:49:17 PM Mark Brown wrote:
> 
> > > Yes, looks like it is.
> 
> > But it doesn't apply for me on top of the current Linus' tree.
> 
> > Can you please rebase?
> 
> It probably depends on other people's trees too, I just killed all the
> usages in -next - I gather the SH trees added some new ones for example.
> I'd expect it'll apply after the merge window, if not that's the time to
> look at it.

OK
