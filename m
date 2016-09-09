From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Sep 2016 17:47:56 +0200
Subject: [PATCH v2 1/2] ARM: dts: Remove use of skeleton.dtsi from
 bcm283x.dtsi
In-Reply-To: <1473432356.28111.60.camel@hellion.org.uk>
References: <1470233565-30154-1-git-send-email-ijc@hellion.org.uk>
 <7746678.0mZLVD2k0J@wuerfel> <1473432356.28111.60.camel@hellion.org.uk>
Message-ID: <5852905.snAkjWmlVZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 9, 2016 3:45:56 PM CEST Ian Campbell wrote:
> On Tue, 2016-08-23 at 12:09 +0200, Arnd Bergmann wrote:
> > I had skipped the new message as well while sorting through 5000
> > messages after my vacation, but I've now put it into my TODO folder
> > and will get to it eventually.
> 
> Is it still on your TODO or should I do...
>
> > We sometimes miss stuff that is meant for arm-soc when it comes
> > from people that don't normally send us patches. If you want to
> > be sure to catch the attention, stick a 'GIT PULL' into the subject
> > or send a ping on IRC.
> 
> ... one of these?
> 
> It'd be great to get this fixed in v4.8 so that the corresponding
> device-tree.git tag will build.

Oh, it ended  up in my v4.9-todo folder, not 4.8, I misunderstood
the urgency, sorry.

I've applied it to the fixes branch now.

	Arnd
