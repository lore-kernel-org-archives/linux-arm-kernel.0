From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 17 Jun 2013 05:03:22 +0200
Subject: [PATCH 0/5] pinctrl: fix some issues with new pinconfig dt parsing
In-Reply-To: <51BB3C62.4070000@imgtec.com>
References: <201306141741.46077.heiko@sntech.de> <51BB3C62.4070000@imgtec.com>
Message-ID: <2162180.An6kI8rHhm@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Friday 14 June 2013 16:53:06 James Hogan wrote:
> On 14/06/13 16:41, Heiko St?bner wrote:
> > Some issues with the recently submitted generic pinconfig parsing from dt
> > came up, so fix these in this follow-up series.
> > 
> > Hopefully I did catch all of them.
> > 
> > Tested on my rk3066 device.
> > 
> > Heiko Stuebner (5):
> >   pinctrl: update the documentation for some pinconfig params
> >   pinctrl: clarify some dt pinconfig options
> >   pinctrl: handle zero found dt pinconfig properties better
> >   pinctrl: dynamically alloc temp array when parsing dt pinconf options
> 
> patches 1-4:
> Reviewed-by: James Hogan <james.hogan@imgtec.com>

Probably too late as Linus has already applied the patches, but for 2, 3 and 4

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
