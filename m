From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 30 Oct 2018 14:56:41 +0000
Subject: [PATCH V3 4/8] dt-bindings: i2c: i2c-imx-lpi2c: add imx8qxp
 compatible string
In-Reply-To: <20181028221952.GF1882@kunai>
References: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
 <1539886483-15775-5-git-send-email-aisheng.dong@nxp.com>
 <20181028221952.GF1882@kunai>
Message-ID: <AM0PR04MB42110EB0836E9610CDA2746680CC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

[...]

> Hi,
> 
> On Thu, Oct 18, 2018 at 06:19:29PM +0000, A.s. Dong wrote:
> > Add imx8qxp compatible string
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-i2c at vger.kernel.org
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Doesn't apply...
> 
> >    - "fsl,imx8dv-lpi2c" for LPI2C compatible with the one integrated
> > on i.MX8DV soc
> 
> ... I don't have this line in my tree.
> 

It seems to be caused by the following commit during the 4.19 RC2+.
f6eb89349078 dt-bindings: imx-lpi2c: Remove mx8dv compatible entry

> Would you maybe volunteer to maintain this driver? To prevent stuff like this
> from happening? :)

Sure, I will open an eye on this driver patches from now on.
And I will resend the patch against your tree.

Thanks

Regards
Dong Aisheng

> 
> Regards,
> 
>    Wolfram
