From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 20:39:05 +0100
Subject: [PATCH 4/4] ARM: Kirkwood: Convert LSXL to restart-poweroff
 driver.
In-Reply-To: <201212282016.59894.michael@walle.cc>
References: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
 <1356697512-3950-5-git-send-email-andrew@lunn.ch>
 <201212282016.59894.michael@walle.cc>
Message-ID: <20121228193905.GE7578@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> Tested-by: Michael Walle <michael@walle.cc>

Hi Michael

Thanks for testing.


> Sort of, device_shutdown() is blocking on my board (seems to be some kind of 
> issue with orion-ehci), but that has nothing to do with this patch :)

Have you tried the USB clock fix:

http://www.spinics.net/lists/arm-kernel/msg213741.html

	Andrew 
