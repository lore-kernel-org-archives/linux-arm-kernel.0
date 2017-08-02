From: erin.lo@mediatek.com (Erin Lo)
Date: Wed, 2 Aug 2017 12:56:14 +0800
Subject: [PATCH 0/5] Add some DT nodes for Mediatek MT2701
In-Reply-To: <f1ea36ee-0a8b-135a-f5f1-67ba7f6dbbce@gmail.com>
References: <1501571013-22327-1-git-send-email-erin.lo@mediatek.com>
 <f1ea36ee-0a8b-135a-f5f1-67ba7f6dbbce@gmail.com>
Message-ID: <1501649774.9992.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Tue, 2017-08-01 at 16:06 +0200, Matthias Brugger wrote:
> Hi Erin,
> 
> On 08/01/2017 09:03 AM, Erin Lo wrote:
> > This patch series based on v4.13-rc1, include MT2701 ethernet/disp bls/display/usb3 function DT nodes.
> > 
> > Chunfeng Yun (1):
> >    arm: dts: mt2701: Add usb3 device nodes
> > 
> > Sean Wang (1):
> >    arm: dts: mt2701: Add ethernet device node
> > 
> > Weiqing Kong (2):
> >    arm: dts: mt2701: Add display bls related nodes for MT2701
> >    arm: dts: mt2701: Add display bls related nodes for MT2701
> > 
> > YT Shen (1):
> >    arm: dts: mt2701: Add display subsystem related nodes for MT2701
> > 
> 
> I took 1/5 and 5/5 in v4.13-next/dts32
> 
> Please reword the commit message on 2/5 and 3/5.
> Also the node should be called pwm instead of bls.
> 
> Regards,
> Matthias
> 

Thanks for your comment.
We will reword pwm instead of bls in next version and send them with 4/5
in recent days.

Regards,
Erin


> >   arch/arm/boot/dts/mt2701-evb.dts |  27 ++++++
> >   arch/arm/boot/dts/mt2701.dtsi    | 189 +++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 216 insertions(+)
> > 
> > --
> > 1.9.1
> > 
