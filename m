From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 6 Feb 2013 09:48:13 -0800
Subject: [PATCH v2 00/30] USB: omap-ehci: Move PHY management to PHY driver
In-Reply-To: <20130206171153.GY25185@atomide.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <5110ECF3.7010908@ti.com> <20130205165851.GA1081@kroah.com>
 <20130205171743.GG25185@atomide.com> <51122730.5030801@ti.com>
 <20130206171153.GY25185@atomide.com>
Message-ID: <20130206174813.GB18681@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 09:11:54AM -0800, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [130206 01:53]:
> > On 02/05/2013 07:17 PM, Tony Lindgren wrote:
> > > * Greg KH <gregkh@linuxfoundation.org> [130205 09:00]:
> > >> On Tue, Feb 05, 2013 at 01:28:51PM +0200, Roger Quadros wrote:
> > >>> Hi Tony & Greg,
> > >>>
> > >>> What's the best way to get these patches in?
> > >>>
> > >>> All patches have been acked by respective maintainers.
> > >>>
> > >>> If Tony can Ack the arch/arm/mach-omap2 stuff then should I send a
> > >>> pull request directly to Greg? or the other way round?
> > >>>
> > >>> Tony, 
> > >>> fyi, these patches should not interfere with the dw3c/musb stuff
> > >>> sent by Felipe & Kishon.
> > >>
> > >> I'm fine with Tony just taking them all if he wants to.
> > > 
> > > OK. Roger, can you please do me a pull request with these
> > > against v3.8-rc6?
> > > 
> > 
> > Tony,
> > 
> > Since this depends on [1] and [2] which are both in linux-next, should
> > I base it on linux-next?
> 
> Maybe you can base it on some commit in Greg's USB tree?
> Just check with Greg that whatever you use as a base is an
> immutable commit and OK to use as a base.

My public git trees should always be immutable and can be used as a
base.

thanks,

greg k-h
