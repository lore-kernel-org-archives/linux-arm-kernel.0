From: woogyom.kim@gmail.com (Milo Kim)
Date: Mon, 2 Jan 2017 16:32:30 +0900
Subject: [PATCH v3 2/3] ARM: dts: imx6: Support Savageboard dual
In-Reply-To: <20170102070302.GD20956@dragon>
References: <20161209010436.7994-1-woogyom.kim@gmail.com>
 <20161209010436.7994-3-woogyom.kim@gmail.com> <20170102070302.GD20956@dragon>
Message-ID: <4a094a99-3b5f-478a-e77e-26673da4a5c2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/02/2017 04:03 PM, Shawn Guo wrote:
>> +	model = "Poslab SavageBoard Dual";
>> +	compatible = "poslab,imx6dl-savageboard", "fsl,imx6dl";
> It seems that 'poslab' should be added to
> Documentation/devicetree/bindings/vendor-prefixes.txt

Ah, right. Thanks for the review!

Best regards,
Milo
