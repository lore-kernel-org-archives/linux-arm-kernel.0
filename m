From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 Apr 2012 03:50:59 +0200
Subject: [PATCH] arm: at91: fix build-error for board-dt
In-Reply-To: <201204211839.15535.arnd@arndb.de>
References: <1335004105-3162-1-git-send-email-w.sang@pengutronix.de>
 <20120421140903.GA6926@pengutronix.de>
 <20120421144304.GD9142@game.jcrosoft.org>
 <201204211839.15535.arnd@arndb.de>
Message-ID: <20120422015059.GE9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:39 Sat 21 Apr     , Arnd Bergmann wrote:
> On Saturday 21 April 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > Ok, we can discard this patch and see it as a bug report.
> > > Since you know best what you'd like, would you send a patch?
> > I'll fix on 3.5 by make it depends on AT91SAM9
> 
> I think it should be fixed for v3.4, especially since it's so easy
> to trigger and the fix will be trivial.
The symbol does not exist before

and the board-dt is sam9 only

Best Regards,
J.
