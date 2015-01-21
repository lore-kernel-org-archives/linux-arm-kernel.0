From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jan 2015 15:43:23 +0100
Subject: [PATCH] arm64: Add L2 cache topology to ARM Ltd boards/models
In-Reply-To: <1421841750-26722-1-git-send-email-sudeep.holla@arm.com>
References: <1421841750-26722-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1542574.d99bFx24pn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 January 2015 12:02:30 Sudeep Holla wrote:
> 
> Hi Arnd/Olof,
> 
> Though this patch and commit 5d425c18653731af6 ("arm64: kernel: add
> support for cpu cache information") which is in -next(via arm64) are
> dependent to provide desired functionality, then can go indepedently
> if you think there could be conflicts if this change is taken via arm64.
> If not, Catalin can pick up with your acks after the review.

I think it would be better to take this through arm-soc. It's not
extremely likely to cause conflicts, but as you say there are no
strict dependencies on which goes in first, so there is no harm
in merging them separately.

	Arnd
