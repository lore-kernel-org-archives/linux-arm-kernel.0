From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 29 May 2013 07:03:44 -0400
Subject: [PATCH 0/3] ARM: PJ4B: fixes for 3.10-rc
In-Reply-To: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
References: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130529110344.GP31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Wed, May 29, 2013 at 12:16:55PM +0200, Gregory CLEMENT wrote:
> Without the first one, the Armada 370 based board can't boot anymore
> since 3.10-rc1 and the commit "ARM: 7691/1: mm: kill unused
> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead" . So this one
> really need to be appplied on 3.10-rc.
> 
> It should be a good thing to apply the others on the 3.10-rc, even we
> didn't observe yet a problem related to these errata, they may happen.

Since Linus in encouraging smaller -rc's, we should probably just submit
the first patch to rmk's patch tracker for v3.10.  The other two should
be considered 'fixes-non-critical' for v3.11.

thx,

Jason.
