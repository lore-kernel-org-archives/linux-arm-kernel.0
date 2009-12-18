From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 18 Dec 2009 15:18:50 +0100
Subject: [PATCH 1/3] ASoC: Add a new imx-ssi sound driver
In-Reply-To: <20091201154920.GW27548@pengutronix.de>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-2-git-send-email-s.hauer@pengutronix.de>
	<20091125155807.GD12750@rakim.wolfsonmicro.main>
	<eedb5540911300840p230fc57fh3fd5c8453b0e1f73@mail.gmail.com>
	<eedb5540911300909vf042b39l44e06b432351b@mail.gmail.com>
	<20091201154920.GW27548@pengutronix.de>
Message-ID: <eedb5540912180618w53e24c6ahe1d47d410e1a91e8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Ok, will do. I myself use the asynchronous mode. The MC13783 I use has
> two SSI ports, one for capture and one for playback. I route both ports
> to the same SSI unit using the audio muxer.
>
> Sascha
>

Dear Sascha,
I don't wanna delay the entering of this driver to mainline. It is clear
that it is cleaner and more generic than mine. And, what we really care, it
works for our board.

If you have any inconvenience with my requirement I could just ack the patch
and maybe we could add support for it later.

Thank you.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091218/2dbf9c0e/attachment-0001.htm>
