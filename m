From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 13 Nov 2018 06:08:44 +0000
Subject: [PATCH 15/23] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
In-Reply-To: <5bea0eb7.1c69fb81.dd309.4a26@mx.google.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-16-Zhiqiang.Hou@nxp.com>
 <5bea0eb7.1c69fb81.dd309.4a26@mx.google.com>
Message-ID: <AM6PR04MB57810984D8C842A2134A836184C20@AM6PR04MB5781.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks a lot for your ACK!

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 2018?11?13? 2:13
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com; Mingkai Hu
> <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>; Xiaowei Bao
> <xiaowei.bao@nxp.com>
> Subject: Re: [PATCH 15/23] dt-bindings: pci: mobiveil: change gpio_slave and
> apb_csr to optional
> 
> On Tue, Nov 06, 2018 at 01:20:41PM +0000, Z.q. Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Change the "gpio_slave" and "apb_csr" to optional, the "gpio_slave"
> > is not used in current code, and "apb_csr" is not used by some
> > platorms.
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/mobiveil-pcie.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Regards,
Zhiqiang
