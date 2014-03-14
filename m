From: Peter.Chen@freescale.com (Peter Chen)
Date: Fri, 14 Mar 2014 01:57:07 +0000
Subject: [PATCH v3][ 3/9] usb: chipidea: Use standard usb-phy property.
In-Reply-To: <5321CF4B.9000308@cogentembedded.com>
References: <1394618518-13803-1-git-send-email-denis@eukrea.com>
 <1394618518-13803-3-git-send-email-denis@eukrea.com>
 <edb50dd0d88541c39fc4b5def88b7f58@BL2PR03MB226.namprd03.prod.outlook.com>
 <5321CF4B.9000308@cogentembedded.com>
Message-ID: <171967ece1414f9ba0e80664777892cb@BL2PR03MB226.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> 
> > According to Power_ePAPR_APPROVED_v1.1.pdf "ethernet-phy" is the node
> > name, it is the same with Sergei's suggestion.
> 
>     Nobody's talking about "ehternet-phy" here.
> 

Hmm, you take "ethernet-phy" as an example, and suggest changing to "usb-phy" at last email.

> > But you have changed the property name at this patch, in fact,
> "fsl,usbphy"
> > is ok for property name, "fsl,usb-phy" may be better, but not worth a
> > patch to change it.
> 
>     No, it's not better and both are not OK because they're still
> Freescale specific while the de-facto standard property "usb-phy" is
> already used by other USB drivers for the same purpose.


Am I missing something, property name should be the same for all platforms?

At Power_ePAPR_APPROVED_v1.1, page 18, the example property name like below:

fsl,channel-fifo-len
ibm,ppc-interrupt-server#s
linux,network-index


Peter
