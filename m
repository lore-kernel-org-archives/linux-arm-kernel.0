From: sam@ravnborg.org (Sam Ravnborg)
Date: Wed, 22 Aug 2018 22:09:42 +0200
Subject: [PATCH v1 1/7] atmel-hlcdc: renamed directory to drm/atmel/
In-Reply-To: <20180816074123.GB21634@phenom.ffwll.local>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-1-sam@ravnborg.org>
 <20180814083913.GD21634@phenom.ffwll.local>
 <20180814161952.GA27951@ravnborg.org>
 <20180816074123.GB21634@phenom.ffwll.local>
Message-ID: <20180822200942.GA22148@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel.

> > > 
> > > I'd strongly suggest you group-maintain the entire atmel stuff in
> > > drm-misc instead of only atmel-hlcdc.
> > 
> > If OK with Boris then I am fine with this too.
> > Will suggest so in v2.
> 
> Boris acked too, but he's on vacation. He said on irc he'll review the
> patches when he's back. Meanwhile I guess you can prep by getting the fd.o
> account requested:
> 
> https://www.freedesktop.org/wiki/AccountRequests/
> 
> And checking out the tooling we use to maintain drm-misc:
> 
> https://dri.freedesktop.org/docs/dim/getting-started.html

With enough on the plate already I decided to postpone this
part until the migration to gitlab is done.
Just to tell this was not ignored, only postponed.

	Sam
