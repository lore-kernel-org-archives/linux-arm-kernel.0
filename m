From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2012 14:09:50 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203141443.57221.sr@denx.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203141327.01038.arnd@arndb.de> <201203141443.57221.sr@denx.de>
Message-ID: <201203141409.51034.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Stefan Roese wrote:
> > I just saw that there is a patch series for pl061 that Rob Herring did at
> > 
> > git://sources.calxeda.com/kernel/linux.git irqdomain-for-grant
> > 
> > Please have a look at that branch first.
> 
> That's for GPIO interrupt support, right? I'll postpone this GPIO interrupt 
> support to a later patch. This one will "only" support the plain GPIO's.
>  

Could be. I haven't actually looked at the series myself, just saw the
email topic earlier today and thought of you.

	Arnd
