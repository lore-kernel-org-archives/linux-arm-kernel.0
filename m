From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Jan 2014 21:28:53 +0100
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <CAOesGMjVpTEku+UJntewi3FXoeEPe9rJP4BBmbSesfFMtY9hnA@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1401171157340.28907@knanqh.ubzr>
 <CAOesGMjVpTEku+UJntewi3FXoeEPe9rJP4BBmbSesfFMtY9hnA@mail.gmail.com>
Message-ID: <201401192128.54413.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 January 2014, Olof Johansson wrote:
> The "multi-slot" concept I was talking about was one host controller
> for several physical slots. Seems like at91 implements and uses this
> but nobody else. However, it seems that they allocate one mmc host per
> slot, so the same model still works.
> 

IIRC dw-mci also has multiple slots, and it's a common host controller
in a number of SoCs. I don't know how many of them actually support
multiple slots rather than a simplified single-slot version of
that controller.

	Arnd
