From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 May 2012 08:27:08 -0700
Subject: [PATCH] pinctrl: Add generic pinctrl-simple driver that
 supports omap2+ padconf
In-Reply-To: <20120503065131.GA3738@game.jcrosoft.org>
References: <20120502172401.GG3739@atomide.com>
 <20120503065131.GA3738@game.jcrosoft.org>
Message-ID: <20120503152708.GC5140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> [120503 00:16]:
> 
> 	I really like it
> 
> 	I was working on something simillar
> 
> 	but can we split the group management so we can use it on other
> 	bindings

Hmm I'm not sure I follow on the group management splitting, can you specify
what you have in mind here?

If you mean moving more things into pinctrl fwk, then yeah I'd assume that
will happen eventually and drivers like this will end up becoming more minimal.

Regards,

Tony
