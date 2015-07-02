From: tony@atomide.com (Tony Lindgren)
Date: Wed, 1 Jul 2015 23:16:21 -0700
Subject: n900 in 4.2-rc0: repeating oopses
In-Reply-To: <20150701130903.GG7969@amd>
References: <20150416093234.GA17423@amd> <20150629091146.GA5103@amd>
 <20150630092404.GA19285@amd> <20150630095310.GF27720@pali>
 <20150701065932.GS4156@atomide.com> <20150701072255.GA17577@pali>
 <20150701095954.GD7969@amd> <20150701103421.GV4156@atomide.com>
 <20150701130903.GG7969@amd>
Message-ID: <20150702061620.GY4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [150701 06:11]:
> On Wed 2015-07-01 03:34:22, Tony Lindgren wrote:
> > 
> > Works for me after enabling the idle timeouts with the following
> > script and blanking the screen and disconnecting USB:
> 
> Um. I'm forcing suspend with "echo mem > /sys/power/state" . (It
> worked in 4.1). That should just make it sleep, no autosuspend-related
> trickery... (But yes, I guess I should set up the leds and try
> autosuspend, too.)

That too works just fine for me with omap2plus_defconfig after
echo enabled > /sys/class/tty/ttyO2/power/wakeup as I have n900
in my test rack.

You probably have some additional drivers enabled?

Regards,

Tony
