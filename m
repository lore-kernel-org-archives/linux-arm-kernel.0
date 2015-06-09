From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 9 Jun 2015 21:22:11 +0200
Subject: [PATCH 00/34] pinctrl: mvebu: numerous fixes, cleanups and
 improvements
In-Reply-To: <20150609170153.GC16778@lunn.ch>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150609170153.GC16778@lunn.ch>
Message-ID: <20150609212211.625964e2@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Tue, 9 Jun 2015 19:01:53 +0200, Andrew Lunn wrote:

> > I wish you good luck when reviewing this. It was boring to do, so I
> > guess it is going to be horribly boring to review :-)
> 
> Not so far :-)

Great :-)

> So i mailed two specific comments, but i think there might be a
> generic problem. You appear to be modifying pinctrl without making
> corresponding changes to .dtsi files? Or have i just missed them?  I
> would of expected the .dtsi file changes to be in the same patch, or
> there are going to be bisect issues.

In fact, for most of the changes there should be zero impact on
the .dtsi or .dts files. Most of the changes are about the subnames
(which don't appear in DT) or adding new functions.

However, you indeed pointed two cases I missed. So I guess I'll have to
review the entire series to double check what is the impact on the DT.
But before doing that, it'd be great to have your point of on the
patches that actually break the DT backward compatibility. If there are
to be rejected anyway, I'd rather not spend more time on them.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
