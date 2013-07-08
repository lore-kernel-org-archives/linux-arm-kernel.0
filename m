From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 8 Jul 2013 09:19:24 +0200
Subject: [alsa-devel] [PATCH v9 08/10] ASoC: Add phycore-ac97-dt driver
In-Reply-To: <CAOMZO5CLWfoQE-9srT8e2kLn3A=iHhk-TbXytV+pdZVaaHwoNg@mail.gmail.com>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-9-git-send-email-mpa@pengutronix.de>
 <20130703161727.GS27646@sirena.org.uk>
 <20130707071949.GH16871@s25.your-server.de>
 <CAOMZO5CLWfoQE-9srT8e2kLn3A=iHhk-TbXytV+pdZVaaHwoNg@mail.gmail.com>
Message-ID: <20130708071924.GP16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Sun, Jul 07, 2013 at 10:16:30AM -0300, Fabio Estevam wrote:
> Hi Markus,
> 
> On Sun, Jul 7, 2013 at 4:19 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > There are no pinctrl driver for imx27(pca100) or imx35(pcm043). The
> 
> For mx35 pinctrl driver is at drivers/pinctrl/pinctrl-imx35.c
> 

Thank you.

I will create some pinctrl bindings for pcm043. But I am not sure what
to do with pca100 reset functions.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
