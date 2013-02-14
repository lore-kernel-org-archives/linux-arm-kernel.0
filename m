From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:11:44 +0000
Subject: [PATCH 4/9] ARM: omap: add include guard for soc.h
In-Reply-To: <20130214225526.GH11362@atomide.com>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-5-git-send-email-arnd@arndb.de>
 <20130214225526.GH11362@atomide.com>
Message-ID: <201302142311.44619.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 February 2013, Tony Lindgren wrote:
> I left it out intentionally as these are private to mach-omap2,
> and I'd like to simplify the indirect includes there further.
> So I'd rather just remove the duplicate soc.h from drm.c.
> 
> If people really think this should be applied, I have no
> objections to this patch naturally.

Either way is fine with me.

	Arnd
