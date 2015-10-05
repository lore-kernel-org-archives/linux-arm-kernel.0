From: rajesh.bhagat@freescale.com (RAJESH BHAGAT)
Date: Mon, 5 Oct 2015 05:37:02 +0000
Subject: [PATCH 1/3][v4] Documentation: dt: dwc3: Add
 snps,quirk-frame-length-adjustment property
In-Reply-To: <20151002195929.GH5552@saruman.tx.rr.com>
References: <1441341894-17327-1-git-send-email-nikhil.badola@freescale.com>
 <SN1PR0301MB1629AAEC687AF3E058BB701DF35A0@SN1PR0301MB1629.namprd03.prod.outlook.com>
 <BN1PR0301MB0675A3534647A872F433E689E9430@BN1PR0301MB0675.namprd03.prod.outlook.com>
 <20151002195929.GH5552@saruman.tx.rr.com>
Message-ID: <CY1PR0301MB068352F2D504B1CC93FA3C8AE9480@CY1PR0301MB0683.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Regarding below patch, Felipe has suggested to talk to you:

> [PATCH 3/3][v4] arm: dts: ls1021a: Add quirk for Erratum A009116

talk to you ARM-SoC maintainer.

https://lkml.org/lkml/2015/9/4/7

Please provide your comments. Inform me in case, if a resend is required.

Best Regards,
Rajesh Bhagat

-----Original Message-----
From: Felipe Balbi [mailto:balbi at ti.com] 
Sent: Saturday, October 03, 2015 1:29 AM
To: Bhagat Rajesh-B56421
Cc: balbi at ti.com; linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-usb at vger.kernel.org
Subject: Re: [PATCH 1/3][v4] Documentation: dt: dwc3: Add snps,quirk-frame-length-adjustment property

On Thu, Sep 24, 2015 at 09:42:59AM +0000, RAJESH BHAGAT wrote:
> Hi Felipe, 
> 
> Any comments on the below [v4] patches?
> 
> [PATCH 1/3][v4] Documentation: dt: dwc3: Add snps,quirk-frame-length-adjustment property

https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=next&id=3737c54418c35034127bf2837e9b27a3c3c67940

> [PATCH 2/3][v4] drivers: usb: dwc3: Add frame length adjustment quirk

https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=next&id=db2be4e9e30c6e43e48c5749d3fc74cee0a6bbb3

> [PATCH 3/3][v4] arm: dts: ls1021a: Add quirk for Erratum A009116

talk to you ARM-SoC maintainer.

> I will be taking forward these patches, as Nikhil has left freescale.

okay, thanks for letting me know.

-- 
balbi
