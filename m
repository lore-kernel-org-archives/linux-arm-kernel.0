From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 08 Nov 2015 00:13:27 +0100
Subject: [PATCH v2 0/9] Better compatible for the rockchip thermal and
 support RK3368 SoCs
In-Reply-To: <563E1E7A.6010503@gmail.com>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
 <1509087.903MXQEqfv@phil> <563E1E7A.6010503@gmail.com>
Message-ID: <4207814.5j47hyHv2C@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Samstag, 7. November 2015, 23:53:30 schrieb Caesar Wang:
> ? 2015?11?07? 03:03, Heiko Stuebner ??:[]
> 
> [....]
> 
> > I call dibs on the devicetree patches :-) .
> >
> > Code and dt parts are very much separate, so I'd like to take the dt parts
> > though my tree and arm-soc to keep further dts changes together.
> > Of course only once you are ok with the code parts :-)
> >
> > Devicetree parts themselfs look ok to me.
> 
> Many thanks, I guess that I don't need send the dts patch again.;-)
> the Code is still a bit change for thermal driver.

I think you should still send the dts patches with next revisions. I can
only take the patches, once Eduardo is satisfied with the code changes
that include the new binding, and while I hope that this will be in v3, it
will be hard if we get to v5 or so, to grep through the older revisions,
trying to find the dts changes :-).


Heiko
