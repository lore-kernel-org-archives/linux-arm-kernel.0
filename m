From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 19 May 2014 08:23:48 +0100
Subject: [PATCH v5 4/8] input: misc: Add driver for AXP20x Power Enable Key
In-Reply-To: <20140519055745.GL29386@core.coreip.homeip.net>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-5-git-send-email-carlo@caione.org>
 <20140503010604.GE4090@lukather>
 <20140519055745.GL29386@core.coreip.homeip.net>
Message-ID: <20140519072348.GD2339@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > This patch add support for the Power Enable Key found on MFD AXP202 and
> > > AXP209. Besides the basic support for the button, the driver adds two
> > > entries in sysfs to configure the time delay for power on/off.
> > > 
> > > Signed-off-by: Carlo Caione <carlo@caione.org>
> > 
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> How are we merging it? MFD tree?

Yes, I'm happy to do that.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
