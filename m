From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 11 Jun 2015 09:53:54 -0400 (EDT)
Subject: [BUG] usb/at91: usb hub does not work
In-Reply-To: <55795803.30302@aksignal.cz>
Message-ID: <Pine.LNX.4.44L0.1506110952460.1465-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Jun 2015, Ji?? Prchal wrote:

> Hi all,
> I discovered some bug when I change kernel from 3.18.13 to 3.18.14. I have board with usb hub CY7C65632 on it.
> In .13 it works fine but in .14 it repeats this message:
> [   19.170000] usb 2-3: new full-speed USB device number 56 using at91_ohci
> and devices connected to usb through hub doesn't appear at all.

> Any idea?

Try using git bisect to find the commit which caused this problem to 
start.

Alan Stern
