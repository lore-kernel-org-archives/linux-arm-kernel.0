From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Jan 2015 15:48:29 +0000
Subject: [PATCH] arm64: Add L2 cache topology to ARM Ltd boards/models
In-Reply-To: <1542574.d99bFx24pn@wuerfel>
References: <1421841750-26722-1-git-send-email-sudeep.holla@arm.com>
 <1542574.d99bFx24pn@wuerfel>
Message-ID: <20150121154828.GG6358@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 02:43:23PM +0000, Arnd Bergmann wrote:
> On Wednesday 21 January 2015 12:02:30 Sudeep Holla wrote:
> > Though this patch and commit 5d425c18653731af6 ("arm64: kernel: add
> > support for cpu cache information") which is in -next(via arm64) are
> > dependent to provide desired functionality, then can go indepedently
> > if you think there could be conflicts if this change is taken via arm64.
> > If not, Catalin can pick up with your acks after the review.
> 
> I think it would be better to take this through arm-soc. It's not
> extremely likely to cause conflicts, but as you say there are no
> strict dependencies on which goes in first, so there is no harm
> in merging them separately.

Fine by me.

-- 
Catalin
