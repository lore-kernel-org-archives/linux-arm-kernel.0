From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 26 Oct 2018 13:52:13 +0000
Subject: [PATCH V2 7/8] dts: fsl: add imx7ulp evk support
In-Reply-To: <20181026105659.yixb64lqia5kisgf@pengutronix.de>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-8-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5C3Fv+s-bLeHGZ6LEB=ZqRxf=gXuzbtwfNS=PvQeVJ1Ag@mail.gmail.com>
 <AM0PR04MB42110E5309341D1626EB6EF980F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAOMZO5BLXGYfvq6GqK66Qe1aTNHmYJOBhKTPKTwNx=tDROKw6Q@mail.gmail.com>
 <AM0PR04MB421195B48BA336AD7078110D80F60@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181026105659.yixb64lqia5kisgf@pengutronix.de>
Message-ID: <AM0PR04MB4211EEE43116F7AC69BCF12380F00@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Friday, October 26, 2018 6:57 PM
[...]
> 
> On Wed, Oct 24, 2018 at 08:14:01AM +0000, A.s. Dong wrote:
> > > -----Original Message-----
> > > From: Fabio Estevam [mailto:festevam at gmail.com]
> > > Sent: Wednesday, October 24, 2018 12:26 AM
> > [...]
> > > On Tue, Oct 23, 2018 at 11:42 AM A.s. Dong <aisheng.dong@nxp.com>
> wrote:
> > >
> > > > I'm a bit hesitate to do that as the driver already supports it.
> > > > There's no extra effort to use it. And we probably could take ULP
> > > > as a special case to test generic binding rather then simply drop
> > > > it and drop driver features. Once we get objection from users
> > > > later, we still can
> > > simply fallback as there's still only official boards using it.
> > >
> > > We had this same discussion some months ago when we were reviewing
> > > i.MX8 support.
> > >
> > > I don't see the value in doing pinctrl differently on i.MX7ULP.
> > >
> >
> > I thought the situation is different as ULP actually already supports
> > generic binding before that discussion.
> >
> > > > Last, it's not correct that there's not only one method for all i.MX devices.
> > > > MX23/28 are different ones and ULP is more like MX23/28.
> > > > And I saw no objections from users for MX23/28.
> > >
> > > Yes, but these are legacy platforms.
> > >
> > > For new ones, we should try to keep consistency, just like we
> > > discussed during
> > > i.MX8 review.
> >
> > So the question is whether it's necessary to switch generic binding
> > back to the legacy one for ULP. Personally I'm not strongly against
> > this, but I need some confirmation from Shawn and Sascha.
> >
> > Shawn & Sascha, would you make a judgement call?
> > If you also strongly request that, I will try to make it patch to test Linus W.
> > Hopefully our agreement could satisfy Linus W.
> 
> For consistency reasons I vote for using the legacy binding for i.MX7ulp aswell.
> 

Thanks for the feedback.
Will try to cook a patch to send to Linus W.

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7C74
> a0d2aca1cf432528a608d63b31c614%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636761482309424341&amp;sdata=Mi5aWJmBcYI3xZLsEdj
> O%2BQ7JUKZS1EzXuW%2Bd2WBJtek%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
