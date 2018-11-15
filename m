From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Thu, 15 Nov 2018 02:27:48 +0000
Subject: [PATCH 15/23] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
In-Reply-To: <CAFZiPx270bWemYRekvk1BZ23RW3ecK+znEc6C1Dix_U-2y+cnA@mail.gmail.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-16-Zhiqiang.Hou@nxp.com>
 <CAFZiPx270bWemYRekvk1BZ23RW3ecK+znEc6C1Dix_U-2y+cnA@mail.gmail.com>
Message-ID: <AM6PR04MB57819B50E52512EF10B26CC984DC0@AM6PR04MB5781.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Subrahmanya,

Thanks a lot for your ACK!

Regards,
Zhiqiang

> -----Original Message-----
> From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Sent: 2018?11?14? 17:33
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; Bjorn Helgaas
> <bhelgaas@google.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> shawnguo at kernel.org; Leo Li <leoyang.li@nxp.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>
> Subject: Re: [PATCH 15/23] dt-bindings: pci: mobiveil: change gpio_slave and
> apb_csr to optional
> 
> Acked-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> 
> On Tue, Nov 6, 2018 at 6:50 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> >
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
> >
> > diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > index a618d4787dd7..64156993e052 100644
> > --- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > @@ -10,8 +10,10 @@ Required properties:
> >         interrupt source. The value must be 1.
> >  - compatible: Should contain "mbvl,gpex40-pcie"
> >  - reg: Should contain PCIe registers location and length
> > +       Mandatory:
> >         "config_axi_slave": PCIe controller registers
> >         "csr_axi_slave"   : Bridge config registers
> > +       Optional:
> >         "gpio_slave"      : GPIO registers to control slot power
> >         "apb_csr"         : MSI registers
> >
> > --
> > 2.17.1
> >
