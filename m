From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Mon, 5 Jul 2010 13:18:39 +0200
Subject: [PATCH 3/4] mx25: fix time accounting
In-Reply-To: <20100704084343.GB19559@jasper.tkos.co.il>
References: <20100125105439.GE6724@jasper.tkos.co.il>
	<fe6ca311cc749bf23a8f99e27ad460ff0aafa69a.1264416923.git.baruch@tkos.co.il>
	<20100511154349.GZ31199@pengutronix.de>
	<20100512050627.GA19283@jasper.tkos.co.il>
	<20100512094642.GB31199@pengutronix.de>
	<20100704084343.GB19559@jasper.tkos.co.il>
Message-ID: <AANLkTimbGOw6zXQXyhaEN_BYrWrMpeun7HRcAP-pv95a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
>
> The strange thing is that the i.MX25 PDK works fine both ways. Maybe the move
> from RedBoot to Barebox has something to do with this ;-). I haven't tried
> Barebox on the PDK while booting from flash.
>
Could this possibly be related to the problem I ran into on MX21 a year ago?

http://www.spinics.net/lists/arm-kernel/msg64267.html

Does the MX25 manual contain any restrictions on the relations between
clock frequencies?

Martin
