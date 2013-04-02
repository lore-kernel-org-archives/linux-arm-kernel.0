From: stigge@antcom.de (Roland Stigge)
Date: Tue, 02 Apr 2013 19:43:35 +0200
Subject: [PATCH] ARM: LPC32xx: changed lpc23xx_restart to lpc32xx_restart
In-Reply-To: <20130402155817.GA25867@quad.lixom.net>
References: <1362601138-16550-1-git-send-email-martinknoll@me.com>
 <20130402155817.GA25867@quad.lixom.net>
Message-ID: <515B18C7.7010803@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/13 17:58, Olof Johansson wrote:
> On Wed, Mar 06, 2013 at 09:18:58PM +0100, Martin Knoll wrote:
>> This function has an odd name. This is probably a typo.
> 
> You should cc the platform maintainer on these kind of patches (Roland Stigge).
> But it seems that he's not actually listed in MAINTAINERS.

I indeed missed the above patch - should be a simple syntactic fix in 3
places in arch/arm/. You can go ahead this time and directly take this
fix. Otherwise, please forward to me so I can add it to a lpc32xx tree
and do request pull.

> Roland, can you send a patch adding yourself as LPC32XX maintainer so these
> kind of patches don't get dropped? Thanks!

OK, just did.

Thanks for notifying!

Roland
