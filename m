From: jbe@pengutronix.de (Juergen Beisert)
Date: Wed, 18 Nov 2009 11:39:18 +0100
Subject: [PATCH 2/3] pcm990-baseboard: don't use pxa_camera init() callback
In-Reply-To: <Pine.LNX.4.64.0911181110180.5702@axis700.grange>
References: <1258495463-26029-1-git-send-email-ospite@studenti.unina.it>
	<1258495463-26029-3-git-send-email-ospite@studenti.unina.it>
	<Pine.LNX.4.64.0911181110180.5702@axis700.grange>
Message-ID: <200911181139.19336.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mittwoch, 18. November 2009, Guennadi Liakhovetski wrote:
> On Tue, 17 Nov 2009, Antonio Ospite wrote:
> > pxa_camera init() is going to be removed.
> > Configure PXA CIF pins directly in machine init function.
>
> Same comment as to patch 1/3.
>
> > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
>
> Even though the change seems obvious, it better be tested - in case
> someone reconfigures camera pins somewhere after
> pcm990_baseboard_init()... Juergen, would you be able to test it?

Lets see, if I can grab some hardware.

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
