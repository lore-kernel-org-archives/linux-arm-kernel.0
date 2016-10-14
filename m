From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 14 Oct 2016 08:13:49 +0200
Subject: Low network throughput on i.MX28
In-Reply-To: <A57BCA39-0977-43C4-B22D-ED60F5E4B06D@embedded.rocks>
References: <1476313753.2065.11.camel@embedded.rocks>
 <20161013084807.6a231fdb@ipc1.ka-ro>
 <A57BCA39-0977-43C4-B22D-ED60F5E4B06D@embedded.rocks>
Message-ID: <20161014081349.1afb22c6@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 13 Oct 2016 21:43:00 +0200 J?rg Krause wrote:
> Am 13. Oktober 2016 08:48:07 MESZ, schrieb "Lothar Wa?mann" <LW@KARO-electronics.de>:
> >On Thu, 13 Oct 2016 01:09:13 +0200 J?rg Krause wrote:
[...]
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
> >
> >You might check your kernel DEBUG configs (especially
> >CONFIG_DEBUG_PAGEALLOC).
> 
> Thanks for sharing the iperf output. What LAN transceiver does the TX28 has assembled?
> 
The ethernet PHY is an SMSC LAN8710A.


Lothar Wa?mann
