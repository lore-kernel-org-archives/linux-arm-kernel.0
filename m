From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Tue, 13 Dec 2011 00:44:01 +0100
Subject: [PATCH 01/10] GPIO: gpio-generic: Move initialization up to
 postcore
In-Reply-To: <20111212231519.GK32251@atomide.com>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <201112130005.35386.jkrzyszt@tis.icnet.pl>
 <20111212231519.GK32251@atomide.com>
Message-ID: <201112130044.02007.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 of December 2011 at 00:15:20, Tony Lindgren wrote:
> 
> Might be worth checking if some board specific __initcall helps here
> too?

If I only knew how I could insert a board specific __initcall between 
two points from where the generic-gpio first, then the 8250 driver, are 
called.

Any hints?

Thanks,
Janusz
