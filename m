From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 22 Mar 2016 23:52:47 +0100
Subject: Who is going to merge it [Was: Re: [PATCH v14 0/17] Add Analogix
 Core Display Port Driver]
In-Reply-To: <56F1CAEB.3080701@samsung.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <1919945.Y1tg0YzXlm@diego> <56F1CAEB.3080701@samsung.com>
Message-ID: <8949624.HmxDpZAlt2@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 23. M?rz 2016, 07:44:59 schrieb Inki Dae:
> + Ajay kumar with Samsung email
> 
> Hi,
> 
> 2016? 03? 23? 07:12? Heiko St?bner ?(?) ? ?:
> > Hi,
> > 
> > Am Dienstag, 22. M?rz 2016, 16:19:37 schrieb Javier Martinez Canillas:
> >> On 03/18/2016 07:53 PM, Doug Anderson wrote:
> >>> On Thu, Mar 17, 2016 at 11:41 PM, Caesar Wang
> >>> <caesar.upstream@gmail.com>
> > 
> > wrote:
> >> Same here, this is the second time I tested this series (first time was
> >> v6 on October 25 [2]) and I think that has been out there for too long.
> >> 
> >>> Tested-by: Douglas Anderson <dianders@chromium.org>
> >> 
> >> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> > 
> > So we have 3 tests (Doug, Caesar and me) for the Rockchip side as well as
> > Javier for the Exynos side based on the most recent drm state.
> > 
> > As said by a lot of people it would be cool to get this merged soon -
> > hopefully directly after -rc1. The only remaining question is through
> > which
> > tree it should go.
> > 
> > I guess there are two basic options:
> > - Inki takes the series - we could see the Rockchip-Ack being implied but
> > maybe Mark can provide an explicit one
> > - Mark takes the series with an Ack from Inki for the shared parts
> > 
> > Inki, Mark do you have a preference?
> 
> The problem would be that there is no drm bridge maintainer. I think the
> most suitable person as the maintainer would be Ajay Kumar who is an author
> of drm bridge framework. Of course, I could take them and have pull-request
> again. But it seems a little late. Dave had already pull-request.

I really meant that for 4.7, not for the current merge window. I just want to 
make sure it goes into a maintainer tree shortly after v4.6-rc1, before 
something else changes the exynos-dp again :-) .


> To Ajay,
> How about adding you as a drm bridge maintainer? DRM SoC driver maintainers
> would need a person who can manage the drm bridge relevant pathes.

The previous example (dw_hdmi generalization between imx and rockchip) did 
just go through the imx tree. So either the Samsung or Rockchip drm-trees 
might be enough?


Heiko
