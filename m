From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 13 Mar 2014 19:31:23 +0400
Subject: [PATCH v3][ 3/9] usb: chipidea: Use standard usb-phy property.
In-Reply-To: <edb50dd0d88541c39fc4b5def88b7f58@BL2PR03MB226.namprd03.prod.outlook.com>
References: <1394618518-13803-1-git-send-email-denis@eukrea.com>
 <1394618518-13803-3-git-send-email-denis@eukrea.com>
 <edb50dd0d88541c39fc4b5def88b7f58@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <5321CF4B.9000308@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-03-2014 7:17, Peter Chen wrote:

>> It also adapt the dts that uses it.

>> Signed-off-by: Denis Carikli <denis@eukrea.com>
[...]

> According to Power_ePAPR_APPROVED_v1.1.pdf
> "ethernet-phy" is the node name, it is the same with Sergei's suggestion.

    Nobody's talking about "ehternet-phy" here.

> But you have changed the property name at this patch, in fact, "fsl,usbphy"
> is ok for property name, "fsl,usb-phy" may be better, but not worth a patch
> to change it.

    No, it's not better and both are not OK because they're still Freescale 
specific while the de-facto standard property "usb-phy" is already used by 
other USB drivers for the same purpose.

> Peter

WBR, Sergei
