From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Mar 2015 07:49:44 +0000
Subject: [PATCH v4 6/9] watchdog: st_wdt: Add new driver for ST's LPC
 Watchdog
In-Reply-To: <1425137789.24292.44.camel@x220>
References: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
 <1424872349-4155-7-git-send-email-lee.jones@linaro.org>
 <1425137789.24292.44.camel@x220>
Message-ID: <20150302074944.GD12821@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 28 Feb 2015, Paul Bolle wrote:
> On Wed, 2015-02-25 at 13:52 +0000, Lee Jones wrote:
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: David Paris <david.paris@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/watchdog/Kconfig      |  13 ++
> >  drivers/watchdog/Makefile     |   1 +
> >  drivers/watchdog/st_lpc_wdt.c | 333 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 347 insertions(+)
> >  create mode 100644 drivers/watchdog/st_lpc_wdt.c
> 
> A few nits follow.

Thanks Paul, will fix.

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
