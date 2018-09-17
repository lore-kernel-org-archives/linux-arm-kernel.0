From: navam@xilinx.com (Nava kishore Manne)
Date: Mon, 17 Sep 2018 09:09:45 +0000
Subject: [RFC PATCH v3 2/3] dt-bindings: reset: Add bindings for ZynqMP
 reset driver
In-Reply-To: <20180910201224.GA31501@bogus>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
 <1536131342-28041-3-git-send-email-nava.manne@xilinx.com>
 <20180910201224.GA31501@bogus>
Message-ID: <BYAPR02MB471009755B88F55A97DA5694C21E0@BYAPR02MB4710.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for providing the comments...
Please find my response inline.

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Tuesday, September 11, 2018 1:42 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mark.rutland at arm.com; Michal Simek <michals@xilinx.com>;
> p.zabel at pengutronix.de; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [RFC PATCH v3 2/3] dt-bindings: reset: Add bindings for ZynqMP
> reset driver
> 
> On Wed, Sep 05, 2018 at 12:39:01PM +0530, Nava kishore Manne wrote:
> > Add documentation to describe Xilinx ZynqMP reset driver bindings.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v3:
> > 		-Corrected Commit Msg.
> > Changes for v2:
> > 		-Moved reset node as a child to firwmare
> > 		 node.
> 
> Why? There's no reason for that. The parent can be multiple providers.
> You only need child nodes if the sub functions have their own DT resources.
> 

This driver having a dependency on firmware. So I have moved this node as a child to firmware
As per other drivers which is using this firmware interface 
https://lkml.org/lkml/2018/8/14/432 
I didn't get your comment could you please elaborate more??? 
Did you mean I should move the changes in the file to Documentation/devicetree/bindings/reset/ ???

Regards,
Navakishore.
