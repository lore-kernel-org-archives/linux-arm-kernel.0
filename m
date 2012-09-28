From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 28 Sep 2012 14:38:53 +0200
Subject: Using ipuv3 driver with device tree
In-Reply-To: <CAOMZO5CUFJ4-J90oVcNDmVLJDd4Q3xtHPKqD+BoADg7gV0gtsw@mail.gmail.com>
References: <CAOMZO5CUFJ4-J90oVcNDmVLJDd4Q3xtHPKqD+BoADg7gV0gtsw@mail.gmail.com>
Message-ID: <20120928123853.GJ24458@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 11:56:00PM -0300, Fabio Estevam wrote:
> Hi Sascha,
> 
> I would like to try the ipuv3 driver on mx53qsb (it can be WVGA, LVDS
> or VGA) and would like to know if there are any patches for the dts
> files I can use for this purpose.
> 
> I am not sure what is the recommended way for passing the video
> timings in dt and looking for an example.

I just wanted to create some followup patches to add the devicetree
support so that you have something to test with, but I found out
that this is not so simple as it seems. The i.MX6 clock lookups will
be switched to devicetree probe, but this is not in -next yet. Current
-next is broken for me right now (haven't figured out why, but CMA
does not work, I get not ethernet link on my babbage board,...)
I think we'll just wait until things have settled after the merge
window until I base further work on the IPU patches.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
