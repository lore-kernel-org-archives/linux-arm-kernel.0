From: woogyom.kim@gmail.com (Milo Kim)
Date: Mon, 2 Jan 2017 16:31:07 +0900
Subject: [PATCH v3 1/3] ARM: dts: imx6: Add Savageboard common file
In-Reply-To: <20170102065239.GC20956@dragon>
References: <20161209010436.7994-1-woogyom.kim@gmail.com>
 <20161209010436.7994-2-woogyom.kim@gmail.com> <20170102065239.GC20956@dragon>
Message-ID: <450d89c7-7459-6369-3a07-cc60d70de0db@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/02/2017 03:52 PM, Shawn Guo wrote:
>> +	panel {
>> +		compatible = "avic, tm097tdh02", "hannstar,hsd100pxn1";
> "avic, tm097tdh02" is an undocumented compatible.
>

AVIC TM097TDH02 panel is compatible with Hannstar HSD100PXN1, so I reuse 
it. It's the same rule as the usage of imx6q I2C controller.

	i2c2: i2c at 021a4000 {
		compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
	};


Best regards,
Milo
