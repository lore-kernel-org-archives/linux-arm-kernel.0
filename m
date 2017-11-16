From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Nov 2017 14:58:07 +0800
Subject: [PATCH v2] arm64: dts: ls1088a: Add USB support
In-Reply-To: <AM3PR04MB12515DB71B8ACF7422A20244E9280@AM3PR04MB1251.eurprd04.prod.outlook.com>
References: <20170913091009.21448-1-yinbo.zhu@nxp.com>
 <20170922065454.GF26358@dragon>
 <VI1PR04MB1262D160BA8625330E32CAF9E9470@VI1PR04MB1262.eurprd04.prod.outlook.com>
 <AM3PR04MB12515DB71B8ACF7422A20244E9280@AM3PR04MB1251.eurprd04.prod.outlook.com>
Message-ID: <20171116065805.GA25176@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 08:00:00AM +0000, Yinbo Zhu wrote:
> On Wed, Sep 13, 2017 at 05:10:09PM +0800, yinbo.zhu at nxp.com wrote:
> > From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> > 
> > Fix the issue that usb is not detected on ls1088ardb
> 
> >It's not really about fixing issue but adding support.
> 
> The patch had been tested on upstream 4.14 code, it can fix the issue. 
> > 
> > Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> 
> >You should better have a version history here to tell what's changed between version.
> 
> >I will add a version history on next v3 patch
> Hi,
> 
> I had modified the code as v4 version, 
> https://patchwork.kernel.org/patch/10027393/
> please check.

You should copy me on that patch, if you expect me to pick it up.

Shawn
