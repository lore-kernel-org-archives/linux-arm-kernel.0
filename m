From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Apr 2016 17:21:37 +0200
Subject: bug in autoloading of imx-ipuv3-crtc
In-Reply-To: <CAPM=9tyyYZqPYz2AHvSDBdG+=LwSELR4m+cc1RrKG0ramZS0ug@mail.gmail.com>
References: <6926808.b0joqYQPQE@anubis.ausil.us>
 <1513165.9WxCa41tI1@anubis.ausil.us>
 <20160420230317.GT29108@pengutronix.de>
 <13533046.1iFyOjiAs0@anubis.ausil.us>
 <CAPM=9tyyYZqPYz2AHvSDBdG+=LwSELR4m+cc1RrKG0ramZS0ug@mail.gmail.com>
Message-ID: <1461770497.4044.53.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 27.04.2016, 08:59 +1000 schrieb Dave Airlie:
> > I reverted the 4 patches in that series
> >
> > 407c9eba drm/imx: Remove of_node assignment from ipuv3-crtc driver probe
> > 304e6be6 gpu: ipu-v3: Assign of_node of child platform devices to
> > corresponding ports
> > 99ae78c3 gpu: ipu-v3: Remove reg_offset field
> > c3ede03c gpu: ipu-v3: drop unused dmfc field from client platform data
> >
> > and it then worked again.
> 
> Should I be reverting these upstream as it's some sort of regression?

I will send an imx-drm/fixes pull request with the issue fixed.

regards
Philipp
