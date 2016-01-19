From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jan 2016 14:18:29 +0000
Subject: [PATCHv2 01/18] asm-generic: make __set_fixmap_offset a static
 inline
In-Reply-To: <5123400.xZnN6QSGxK@wuerfel>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
 <1451930211-22460-2-git-send-email-mark.rutland@arm.com>
 <20160119115539.GE25024@leverpostej> <5123400.xZnN6QSGxK@wuerfel>
Message-ID: <20160119141829.GE26545@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 03:11:09PM +0100, Arnd Bergmann wrote:
> On Tuesday 19 January 2016 11:55:40 Mark Rutland wrote:
> > Hi Arnd,
> > 
> > Sorry to poke during the merge window.
> > 
> > Are you happy with the below patch, and if so, would you be happy for
> > this to go via the arm64 tree?
> > 
> > If possible, I'd like to be able to place the series on a stable branch
> > come -rc1, so that can be used as the base for other work (e.g. [1]),
> > and so that we can get it into -next.
> > 
> > Everything else has the appropriate acks collected.
> > 
> > 
> 
> Yes, please merge it through arm64
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Cheers!

Mark.
