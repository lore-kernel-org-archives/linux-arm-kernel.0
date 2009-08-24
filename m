From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 24 Aug 2009 11:11:28 +0200
Subject: [PATCH] watchdog: Add support for the Avionic Design Xanthos
	watchdog timer.
In-Reply-To: <20090822081806.GD29382@infomag.iguana.be>
References: <20090821073105.GC29382@infomag.iguana.be>
	<1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>
	<20090822081806.GD29382@infomag.iguana.be>
Message-ID: <20090824091128.GA32109@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wim Van Sebroeck wrote:
> Hi Thierry,
> 
> > + * linux/drivers/watchdog/adx_wdt.c
> 
> Please change this to adx_wdt.c . If the tree get's moved then we don't want to review every driver to get this "fixed".

Is it okay with you if I just drop this line altogether? It really just noise
anyway.

Thierry
