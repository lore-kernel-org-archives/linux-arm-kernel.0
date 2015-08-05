From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 05 Aug 2015 10:15:12 -0700
Subject: [PATCH 2/2] MAINTAINERS: Explicitly add linux-arm-kernel for
 bcm2835
In-Reply-To: <1437594937-28583-2-git-send-email-eric@anholt.net>
References: <1437594937-28583-1-git-send-email-eric@anholt.net>
 <1437594937-28583-2-git-send-email-eric@anholt.net>
Message-ID: <55C244A0.1060101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/15 12:55, Eric Anholt wrote:
> get_maintainers.pl would list linux-arm-kernel for most bcm2835
> changes because it's under arch/arm, but might not for other bcm2835
> drivers.  Most ARM architectures appear to list linux-arm-kernel as an
> appropriate list as well.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Suggested-by: Stephen Warren <swarren@wwwdotorg.org>

Also applied, thanks!
-- 
Florian
