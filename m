From: tony@atomide.com (Tony Lindgren)
Date: Sun, 27 Oct 2013 05:23:48 -0700
Subject: [PATCHv2 1/3] Input: twl4030-keypad - add device tree support
In-Reply-To: <20131027114753.GB14901@amd.pavel.ucw.cz>
References: <1382446042-27099-1-git-send-email-sre@debian.org>
 <1382446042-27099-2-git-send-email-sre@debian.org>
 <20131027111715.GA2437@xo-6d-61-c0.localdomain>
 <20131027114026.GB14091@earth.universe>
 <20131027114753.GB14901@amd.pavel.ucw.cz>
Message-ID: <20131027122347.GE15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [131027 04:48]:
> 
> > > > +#if IS_ENABLED(CONFIG_OF)
> > > I'm probably missing something here, but why not #ifdef CONFIG_OF?
> > 
> > I have been told for other drivers, that IS_ENABLED() is
> > the prefered way to check for configuration these days.
> 
> CONFIG_OF can not be module, using IS_ENABLED() on it is just wrong.

Good point. Looks like there's IS_BUILTIN that's for boolean options.

Regards,

Tony
