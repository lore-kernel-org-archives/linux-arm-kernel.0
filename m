From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 29 Jun 2016 09:48:19 +0200
Subject: [PATCH 4/7] reset: Supply *_shared variant calls when using
 *_optional APIs
In-Reply-To: <20160628085622.GM6720@dell>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-5-lee.jones@linaro.org> <20160628085622.GM6720@dell>
Message-ID: <1467186499.2278.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Am Dienstag, den 28.06.2016, 09:56 +0100 schrieb Lee Jones:
> Philipp,
> 
> I need this to go into the -rcs too.
> 
> Can I add it with your Ack please?

I have already added your patches to my branch, and I intend to send a
pull request for it tomorrow. I am afraid applying this patch in another
branch would create a merge conflict with
git://git.pengutronix.de/git/pza/linux.git reset/next
in arm-soc. If that is not the case, go ahead. Otherwise I could provide
a tag at commit 2485394d9e0b ("reset: TRIVIAL: Add line break at same
place for similar APIs") for you to merge.

regards
Philipp
