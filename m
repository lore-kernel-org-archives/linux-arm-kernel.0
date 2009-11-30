From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 30 Nov 2009 11:43:23 +0100
Subject: [alsa-devel] [PATCH V2] Add i.MX sound support
In-Reply-To: <20091127095416.GK27548@pengutronix.de>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<eedb5540911260753u369d6cffp97c05089cdd30868@mail.gmail.com>
	<20091127075834.GG27548@pengutronix.de>
	<eedb5540911270101o4bf06b2ct6ff22e29b7c1fe15@mail.gmail.com>
	<20091127095416.GK27548@pengutronix.de>
Message-ID: <eedb5540911300243t20ecf407o317b414720cf962e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,
have you tested capture direction on an i.MX27 based board?

I have been testing your patches in the place you suggested and playback
seems to work fine but I have several problems with capture stream. I found
a BUG in the audmux_v1 code
and I have fixed it but I am still having problems with capture. The file
keeps empty and nothing is recorded.

Please could you try the following on an i.MX27 based board?

arecord -t raw -c 1 -f S16_LE test.wav

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091130/96640f2d/attachment-0001.htm>
