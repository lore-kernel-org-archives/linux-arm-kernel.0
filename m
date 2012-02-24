From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Feb 2012 08:25:14 -0800
Subject: [PATCH 4/7] ARM: OMAP2+: Fix zoom LCD backlight if TWL_CORE is
 not selected
In-Reply-To: <4F477A56.9000005@ru.mvista.com>
References: <20120224005324.16794.73852.stgit@kaulin.local>
 <20120224005411.16794.720.stgit@kaulin.local>
 <4F477A56.9000005@ru.mvista.com>
Message-ID: <20120224162514.GK18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sergei Shtylyov <sshtylyov@ru.mvista.com> [120224 03:23]:
> 
> On 24-02-2012 4:54, Tony Lindgren wrote:
> >--- a/arch/arm/mach-omap2/board-zoom-display.c
> >+++ b/arch/arm/mach-omap2/board-zoom-display.c
> >@@ -53,8 +53,11 @@ static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
> >  #define TWL_LED_PWMON	0x0
> >  #define TWL_LED_PWMOFF	0x1
> >
> >+
> >  static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
> >  {
> >+
> 
>    Empty lines not needed.

Thanks removing those.

Tony
