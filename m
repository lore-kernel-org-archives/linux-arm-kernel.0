From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 28 Sep 2012 09:30:21 +0200
Subject: Using ipuv3 driver with device tree
In-Reply-To: <CAOMZO5CUFJ4-J90oVcNDmVLJDd4Q3xtHPKqD+BoADg7gV0gtsw@mail.gmail.com>
References: <CAOMZO5CUFJ4-J90oVcNDmVLJDd4Q3xtHPKqD+BoADg7gV0gtsw@mail.gmail.com>
Message-ID: <20120928073021.GY1322@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Sep 27, 2012 at 11:56:00PM -0300, Fabio Estevam wrote:
> Hi Sascha,
> 
> I would like to try the ipuv3 driver on mx53qsb (it can be WVGA, LVDS
> or VGA) and would like to know if there are any patches for the dts
> files I can use for this purpose.

I'll send patches for the dts very soon.

> 
> I am not sure what is the recommended way for passing the video
> timings in dt and looking for an example.

Right now the only way for passing video timings is using an EDID blob
in the devicetree. We are currently trying to change this, but it seems
it will take some time. See this thread:

[PATCH v5] of: add display helper (was: of: add videomode helper) 

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
