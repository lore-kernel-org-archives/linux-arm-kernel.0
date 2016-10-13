From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Oct 2016 22:42:35 +0200
Subject: Low network throughput on i.MX28
In-Reply-To: <A57BCA39-0977-43C4-B22D-ED60F5E4B06D@embedded.rocks>
References: <1476313753.2065.11.camel@embedded.rocks>
 <20161013084807.6a231fdb@ipc1.ka-ro>
 <A57BCA39-0977-43C4-B22D-ED60F5E4B06D@embedded.rocks>
Message-ID: <20161013204234.c5d7htdngtmj4goh@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Oct 13, 2016 at 09:43:00PM +0200, J?rg Krause wrote:
> Am 13. Oktober 2016 08:48:07 MESZ, schrieb "Lothar Wa?mann" <LW@KARO-electronics.de>:
> >This is the iperf output on a TX28 with current mainline kernel
> >(4.8.0-rc5):
> >------------------------------------------------------------
> >Client connecting to 192.168.100.1, TCP port 5001
> >TCP window size: 43.8 KByte (default)
> >------------------------------------------------------------
> >[  3] local 192.168.100.56 port 60325 connected with 192.168.100.1 port
> >5001
> >[ ID] Interval       Transfer     Bandwidth
> >[  3]  0.0-10.0 sec  57.5 MBytes  48.2 Mbits/sec

Just for the record: I have another i.MX28 system here and got 43
Mbits/sec with PREEMPT_NONE and 37 Mbits/sec with PREEMPT_RT both using
a 3.14 kernel.

> >You might check your kernel DEBUG configs (especially
> >CONFIG_DEBUG_PAGEALLOC).
> 
> Thanks for sharing the iperf output. What LAN transceiver does the
> TX28 has assembled?

My system has a Marvell Switch (88e6083) as "transceiver".

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
