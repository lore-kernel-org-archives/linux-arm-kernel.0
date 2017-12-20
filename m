From: yinbo.zhu@nxp.com (Yinbo Zhu)
Date: Wed, 20 Dec 2017 04:42:59 +0000
Subject: [PATCH v2] arm64: dts: ls1088a: Add USB support
In-Reply-To: <20171220025239.GB3766@dragon>
References: <20170913091009.21448-1-yinbo.zhu@nxp.com>
 <20170922065454.GF26358@dragon>
 <VI1PR04MB1262D160BA8625330E32CAF9E9470@VI1PR04MB1262.eurprd04.prod.outlook.com>
 <AM3PR04MB12515DB71B8ACF7422A20244E9280@AM3PR04MB1251.eurprd04.prod.outlook.com>
 <VI1PR04MB1262DD3C6A18257DEE2E907DE9200@VI1PR04MB1262.eurprd04.prod.outlook.com>
 <VI1PR04MB1262C44016CE4ECB8902E7E7E9330@VI1PR04MB1262.eurprd04.prod.outlook.com>
 <20171220025239.GB3766@dragon>
Message-ID: <HE1PR0401MB19451C3CFAA694F965B30F0FE90C0@HE1PR0401MB1945.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Shawn Guo [mailto:shawnguo at kernel.org] 
Sent: Wednesday, December 20, 2017 10:53 AM
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Catalin Marinas ) <catalin.marinas@arm.com>; Will Deacon ) <will.deacon@arm.com>; Harninder Rai <harninder.rai@nxp.com>; Raghav Dogra <raghav.dogra@nxp.com>; Ashish Kumar <ashish.kumar@nxp.com>; Andy Tang <andy.tang@nxp.com>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org; open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ls1088a: Add USB support

On Thu, Dec 07, 2017 at 07:33:28AM +0000, Yinbo Zhu wrote:
> Hi shawn guo,
> 
> If my patch has no other issue,
> Can you help me push it to upstream.

>Are you talking about v4 patch?  First of all, I cannot find v4 in my mailbox.  That said, it seems you did not send 

>the patch to me.
>Secondly, by checking the patch on patchwork, the usb nodes in fsl-ls1088a-rdb.dts do not sorted alphabetically 

>in label name.

>Shawn

Hi shawn, 
 I will change the code as follows, right?

&esdhc {
 	status = "okay";
 };
...
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
https://patchwork.kernel.org/patch/10059097/

Thanks
Yinbo.
