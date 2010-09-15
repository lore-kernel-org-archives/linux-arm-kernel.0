From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 15 Sep 2010 14:08:44 +0800
Subject: [PATCH 0/3] Common struct clk implementation, v7
In-Reply-To: <20100915055320.GB23518@game.jcrosoft.org>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<20100915055320.GB23518@game.jcrosoft.org>
Message-ID: <1284530924.3350.7.camel@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

> 	please put sh ml in cc too as we use the same clkdev

Sure, the sh folks may be interested in this too; would be nice to share
the common clock with sh.

However, these changes won't affect any platform unless
CONFIG_USE_COMMON_STRUCT_CLK is set; so the changes won't affect sh by
default. When/if this is merged, I'd like to look at integrating other
arches (powerpc and sh). Of course, comments are welcome in the
meantime.

sh folks: to avoid fragmenting the discussion and filling up everyone's
inbox I'll refrain from re-posting this series. Patches are here if
you're interested:

http://kernel.ubuntu.com/git?p=jk/dt/linux-2.6.git;a=shortlog;h=refs/heads/clk-common

Cheers,


Jeremy
