From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Feb 2015 17:14:09 +0100
Subject: [PATCH] arm64: Add L2 cache topology to ARM Ltd boards/models
In-Reply-To: <54EC9546.50005@arm.com>
References: <1421841750-26722-1-git-send-email-sudeep.holla@arm.com>
 <1542574.d99bFx24pn@wuerfel> <54EC9546.50005@arm.com>
Message-ID: <2231708.1y1gnmyPQn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 15:14:14 Sudeep Holla wrote:
> Hi Arnd,
> 
> On 21/01/15 14:43, Arnd Bergmann wrote:
> > On Wednesday 21 January 2015 12:02:30 Sudeep Holla wrote:
> >>
> >> Hi Arnd/Olof,
> >>
> >> Though this patch and commit 5d425c18653731af6 ("arm64: kernel: add
> >> support for cpu cache information") which is in -next(via arm64) are
> >> dependent to provide desired functionality, then can go indepedently
> >> if you think there could be conflicts if this change is taken via arm64.
> >> If not, Catalin can pick up with your acks after the review.
> >
> > I think it would be better to take this through arm-soc. It's not
> > extremely likely to cause conflicts, but as you say there are no
> > strict dependencies on which goes in first, so there is no harm
> > in merging them separately.
> >
> 
> I think this patch got missed for -rc1. The arm64 architectural
> support patch for cacheinfo got merged via arm64 tree. It would be good
> if this is also merged so that cache information can be exposed
> to the user-space on ARM Ltd boards.
> 

Ah, bummer. I've applied this one as a fix for 4.0 because I said we'd
take it and dropped the ball on it.

	Arnd
