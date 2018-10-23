From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Oct 2018 13:25:53 -0300
Subject: [PATCH V2 7/8] dts: fsl: add imx7ulp evk support
In-Reply-To: <AM0PR04MB42110E5309341D1626EB6EF980F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-8-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5C3Fv+s-bLeHGZ6LEB=ZqRxf=gXuzbtwfNS=PvQeVJ1Ag@mail.gmail.com>
 <AM0PR04MB42110E5309341D1626EB6EF980F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5BLXGYfvq6GqK66Qe1aTNHmYJOBhKTPKTwNx=tDROKw6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 11:42 AM A.s. Dong <aisheng.dong@nxp.com> wrote:

> I'm a bit hesitate to do that as the driver already supports it. There's no extra effort
> to use it. And we probably could take ULP as a special case to test generic binding
> rather then simply drop it and drop driver features. Once we get objection from users
> later, we still can simply fallback as there's still only official boards using it.

We had this same discussion some months ago when we were reviewing
i.MX8 support.

I don't see the value in doing pinctrl differently on i.MX7ULP.

> Last, it's not correct that there's not only one method for all i.MX devices.
> MX23/28 are different ones and ULP is more like MX23/28.
> And I saw no objections from users for MX23/28.

Yes, but these are legacy platforms.

For new ones, we should try to keep consistency, just like we
discussed during i.MX8 review.
