From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 20 Oct 2017 09:38:54 +0200
Subject: [PATCH] pinctrl: rockchip: Add iomux-route switching support for
 rk3288
In-Reply-To: <52d1a9ee-a6c6-5c7f-330f-9b672be9c2c6@xs4all.nl>
References: <20171013225337.5196-1-phh@phh.me> <13020229.tRmotBUImn@phil>
 <52d1a9ee-a6c6-5c7f-330f-9b672be9c2c6@xs4all.nl>
Message-ID: <2040825.vRYCsv903Y@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Am Freitag, 20. Oktober 2017, 09:28:58 CEST schrieb Hans Verkuil:
> On 14/10/17 17:39, Heiko Stuebner wrote:
> > So far only the hdmi cec supports using one of two different pins
> > as source, so add the route switching for it.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> Just tested this on my firefly reload and it works great!
> 
> Tested-by: Hans Verkuil <hans.verkuil@cisco.com>

oh cool. I really only wrote this based on the soc manual,
so it actually surprises me, that it works on the first try :-)

> I'll post some dts patches later today to fully bring up the first HDMI
> output on the Firefly Reload.
> 
> Will you process this patch further to get it mainlined?

Yep, I'll do that.


Heiko
