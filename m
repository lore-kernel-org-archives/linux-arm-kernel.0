From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 May 2011 13:52:55 +0200
Subject: [PATCH 0/3] SPEAr320: Add pwm support
In-Reply-To: <20110530114405.GD23771@pengutronix.de>
References: <cover.1306739836.git.viresh.kumar@st.com>
	<4DE353F8.9040207@st.com> <20110530114405.GD23771@pengutronix.de>
Message-ID: <201105301352.55570.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 May 2011, Sascha Hauer wrote:
> > Sascha sent a patchset for something similar earlier.
> > But don't know what happened to it.
> 
> Nothing yet, unfortunately. It was a straight forward implementation
> which basically implements the existing pwm functions and adds
> register/unregister functions.
> Bill Gatliff posts a pwm framework since 2008. I wasn't aware of his
> patches by the time I wrote my pwm layer. Bills patches target more the
> motor controller use case and are (in my opinion) too complicated. I
> can't agree on his approach, but didn't want to go with competing
> patches either.
> 
> As Bills patches still didn't make it into the kernel Maybe it's time
> to respin my version.

Yes, I think that would be good, then we can add the new SPEAr320 pwm
driver to the new subsystem as a first example, and move the other
drivers over after that.

	Arnd
