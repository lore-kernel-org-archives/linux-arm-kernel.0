From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 12 Sep 2014 01:46:49 +0000
Subject: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <1444adbcf7cd4b578a131db11e662490@BN1PR0301MB0593.namprd03.prod.outlook.com>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <1410253952-15631-2-git-send-email-jingchang.lu@freescale.com>
 <1444adbcf7cd4b578a131db11e662490@BN1PR0301MB0593.namprd03.prod.outlook.com>
Message-ID: <41c81e91c363494babb72ccc50b8961c@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Badola Nikhil-B46172
>Sent: Thursday, September 11, 2014 6:11 PM
>To: Lu Jingchang-B35083; Guo Shawn-R65073
>Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; Lu
>Jingchang-B35083; Zhao Chenhui-B35336; Gupta Suresh-B42813; Leekha
>Shaveta-B20052; Gupta Ruchika-R66431; Sharma Bhupesh-B45370; Fu Chao-
>B44548; Xiubo Li-B47053; Lu Jingchang-B35083
>Subject: RE: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
>LS1021A
>
>>-----Original Message-----
>>From: Jingchang Lu [mailto:jingchang.lu at freescale.com]
>>Sent: Tuesday, September 09, 2014 2:42 PM
>>To: Guo Shawn-R65073
>>Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
>>Lu Jingchang-B35083; Badola Nikhil-B46172; Zhao Chenhui-B35336; Gupta
>>Suresh- B42813; Leekha Shaveta-B20052; Gupta Ruchika-R66431; Sharma
>>Bhupesh- B45370; Fu Chao-B44548; Xiubo Li-B47053; Lu Jingchang-B35083
>>Subject: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
>>LS1021A
>>
>>From: Jingchang Lu <b35083@freescale.com>
>>
>>Add Freescale LS1021A SoC device tree support
>>+
>>+		usb at 8600000 {
>>+			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
>>+			reg = <0x0 0x8600000 0x0 0x1000>;
>>+			#address-cells = <1>;
>>+			#size-cells = <0>;
>>+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
>>+			dr_mode = "host";
>>+			phy_type = "ulpi";
>>+		};
>>+
>
>Please remove following from the above node :
>			#address-cells = <1>;
>			#size-cells = <0>;

Ok, thanks.



Best Regards,
Jingchang
