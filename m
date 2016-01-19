From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jan 2016 15:11:09 +0100
Subject: [PATCHv2 01/18] asm-generic: make __set_fixmap_offset a static
 inline
In-Reply-To: <20160119115539.GE25024@leverpostej>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
 <1451930211-22460-2-git-send-email-mark.rutland@arm.com>
 <20160119115539.GE25024@leverpostej>
Message-ID: <5123400.xZnN6QSGxK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 January 2016 11:55:40 Mark Rutland wrote:
> Hi Arnd,
> 
> Sorry to poke during the merge window.
> 
> Are you happy with the below patch, and if so, would you be happy for
> this to go via the arm64 tree?
> 
> If possible, I'd like to be able to place the series on a stable branch
> come -rc1, so that can be used as the base for other work (e.g. [1]),
> and so that we can get it into -next.
> 
> Everything else has the appropriate acks collected.
> 
> 

Yes, please merge it through arm64

Acked-by: Arnd Bergmann <arnd@arndb.de>
