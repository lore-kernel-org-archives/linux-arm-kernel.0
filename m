From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 May 2011 14:53:40 +0200
Subject: [PATCH 0/3] SPEAr320: Add pwm support
In-Reply-To: <4DE38616.7050901@st.com>
References: <cover.1306739836.git.viresh.kumar@st.com>
	<201105301352.55570.arnd@arndb.de> <4DE38616.7050901@st.com>
Message-ID: <201105301453.40314.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 May 2011, viresh kumar wrote:
> >> As Bills patches still didn't make it into the kernel Maybe it's time
> >> to respin my version.
> > 
> > Yes, I think that would be good, then we can add the new SPEAr320 pwm
> > driver to the new subsystem as a first example, and move the other
> > drivers over after that.
> > 
> 
> Obviously this can be done, but as it has already taken too long for that
> framework to get added in mainline, and still we don't know how much more
> time it will take. I would suggest to push this patchset now. And i
> will update this accordingly once that framework comes up.

Ok, makes sense.

How about starting a drivers/pwm directory though? I think we have
broad support for the idea of moving drivers into their subsystems,
so even if you don't change the code, I think it would be a better
place than drivers/misc.

	Arnd
