From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 1 Oct 2012 11:36:42 +0100
Subject: [PATCH 1/4] mfd: ab8500: add devicetree support for fuelgauge
In-Reply-To: <50696991.2080103@stericsson.com>
References: <1349064513-31301-1-git-send-email-rajanikanth.hv@stericsson.com>
 <1349064513-31301-2-git-send-email-rajanikanth.hv@stericsson.com>
 <20121001094929.GB6682@gmail.com> <50696991.2080103@stericsson.com>
Message-ID: <20121001103642.GE6682@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> did you have a look at arnd and anton comments regarding
> 'supplied-to' and boolean property

Try to keep your comments inline, situated below the relevant comment.

> >> +     ab8500_battery_info: ab8500_bat_type {
> >> +             battery-type = <2>;
> >> +             thermistor-on-batctrl = <1>;

> > You have this as a bool here, and ...

> >> +     e.g:
> >> +     ab8500_battery_info: ab8500_bat_type {
> >> +             thermistor-on-batctrl;

> > ... a standard property here. I suggest you drop the bool value.

I'm guessing it's just the documentation that needs amending.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
