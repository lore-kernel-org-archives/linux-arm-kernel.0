From: michael@walle.cc (Michael Walle)
Date: Sat, 29 Dec 2012 00:11:25 +0100
Subject: [PATCH 4/4] ARM: Kirkwood: Convert LSXL to restart-poweroff
 driver.
In-Reply-To: <20121228193905.GE7578@lunn.ch>
References: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
 <201212282016.59894.michael@walle.cc> <20121228193905.GE7578@lunn.ch>
Message-ID: <201212290011.25647.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag 28 Dezember 2012, 20:39:05 schrieb Andrew Lunn:
> > Tested-by: Michael Walle <michael@walle.cc>
> 
> Hi Michael
> 
> Thanks for testing.
> 
> > Sort of, device_shutdown() is blocking on my board (seems to be some kind
> > of issue with orion-ehci), but that has nothing to do with this patch :)
> 
> Have you tried the USB clock fix:
> 
> http://www.spinics.net/lists/arm-kernel/msg213741.html
> 
> 	Andrew

ah thanks, that fixed it.


-- 
Michael
