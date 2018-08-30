From: leoyang.li@nxp.com (Li Yang)
Date: Thu, 30 Aug 2018 12:04:48 -0500
Subject: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
In-Reply-To: <VI1PR04MB32475E7E36BA8467FC07B01D91080@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <20180829200425.16435-1-robh@kernel.org>
 <VI1PR04MB32475E7E36BA8467FC07B01D91080@VI1PR04MB3247.eurprd04.prod.outlook.com>
Message-ID: <CADRPPNTWQP7kgB8O4LJ67H237z=o8KEscT0i7nveNVFvodb+AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 9:49 PM Qiang Zhao <qiang.zhao@nxp.com> wrote:
>
> From: Rob Herring <robh@kernel.org>
> date: 2018/8/30 4:04
>
> > To: Qiang Zhao <qiang.zhao@nxp.com>
> > Cc: linux-kernel at vger.kernel.org; Leo Li <leoyang.li@nxp.com>;
> > linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org
> > Subject: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
> >
> > Use the of_get_child_by_name() helper instead of open coding searching for the
> > 'firmware' child node. This removes directly accessing the name pointer as well.
> >
> > Cc: Qiang Zhao <qiang.zhao@nxp.com>
> > Cc: Li Yang <leoyang.li@nxp.com>
> > Cc: linuxppc-dev at lists.ozlabs.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>

Merged for next.  Thanks.

Regards,
Leo
