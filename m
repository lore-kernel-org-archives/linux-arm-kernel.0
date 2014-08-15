From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 15 Aug 2014 15:03:14 -0400
Subject: Random MAC address on my BeagleBone White
In-Reply-To: <20140815184911.GJ17027@pengutronix.de>
References: <20140815134221.08c546a0@gandalf.local.home>
 <20140815184911.GJ17027@pengutronix.de>
Message-ID: <20140815150314.60d01877@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Aug 2014 20:49:11 +0200
Markus Pargmann <mpa@pengutronix.de> wrote:

> Hi Steven,
> 
 
> The am335x SoC already has 4 registers which contain two unique vendor
> MAC addresses, so they should be used automatically instead of a random
> one.
> 
> As you mentioned above, I sent a series to read and use those addresses
> in the linux kernel. There were some problems with the series which I
> fixed to send a new version of the series, but I didn't send it yet. I
> will try to resend it tomorrow and Cc you. It would be great if you
> could test it.
> 

Yep, but I don't work on weekends (Chief Home Officer's orders). Well,
I should say, I don't do computer work on weekends. House work on the
other hand, plenty (Again, the CHO's orders). It will have to wait till
Monday.

> As far as I know, barebox also works with the beaglebone white and it
> should set the correct MAC address as well. So if you need the same IP
> address in linux as in the bootloader, you could try barebox.

Maybe I'll give it a try. But if your stuff works I'll be fine with
that.

Thanks! Hopefully I'll be using this board in my ktest tutorial at
ELCEU in October.

-- Steve
