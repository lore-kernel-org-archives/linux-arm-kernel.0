From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 23:47:46 +0200
Subject: [PATCH, RFC 19/22] staging/solo6x10: depend on CONFIG_FONTS
In-Reply-To: <CAMuHMdWrVCndJ=Cre5LUgTSyQMxn_XkHUCFa2qCz-ETUO+T-ug@mail.gmail.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-20-git-send-email-arnd@arndb.de>
 <CAMuHMdWrVCndJ=Cre5LUgTSyQMxn_XkHUCFa2qCz-ETUO+T-ug@mail.gmail.com>
Message-ID: <201305232347.47080.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Geert Uytterhoeven wrote:
> Sorry for only noticing this now, but CONFIG_FONTS is not about font support.
> It's about allowing the user to override the default list of builtin fonts.
> I know it's a bad name, but changing this would break make oldconfig.
> Or is this allowed?
> 
> My fix for the solo6x10 build breakage is
> http://marc.info/?l=linux-kernel&amp;m=136861809223875

Right, that sounds like a better solution.

	Arnd
