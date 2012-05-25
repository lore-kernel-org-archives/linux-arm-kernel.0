From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 25 May 2012 16:51:02 +0200
Subject: Booting mx27 on linux-next
In-Reply-To: <CAOMZO5Bz44hrXRULui2GEjSL9y-S58P-_05aKsQB6jtgA7-hgg@mail.gmail.com>
References: <CAOMZO5Bz44hrXRULui2GEjSL9y-S58P-_05aKsQB6jtgA7-hgg@mail.gmail.com>
Message-ID: <20120525145102.GR30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, May 25, 2012 at 10:56:07AM -0300, Fabio Estevam wrote:
> Hi Sascha,
> 
> Just tried booting a mx27pdk on linux-next and it failed to boot.
> 
> Any patches I am missing?
> 
> Just wanted to check with you first prior to start debugging it.

Works for me, tested on next-20120524 on a pcm038 board. I just had
to disable nand support, see the patches I just sent to the list.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
