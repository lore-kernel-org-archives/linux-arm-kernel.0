From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Fri, 23 Mar 2018 07:59:33 +0000
Subject: [PATCH 1/2][v6] dt-bindings: mtd-physmap: Add endianness supports
In-Reply-To: <20180312081128.8195-1-prabhakar.kushwaha@nxp.com>
References: <20180312081128.8195-1-prabhakar.kushwaha@nxp.com>
Message-ID: <VI1PR0402MB385471846E1D3B747C67B48D97A80@VI1PR0402MB3854.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,


> -----Original Message-----
> From: Prabhakar Kushwaha
> Sent: Monday, March 12, 2018 1:41 PM
> To: linux-mtd at lists.infradead.org; devicetree at vger.kernel.org;
> robh at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org
> Cc: boris.brezillon at free-electrons.com; computersforpeace at gmail.com;
> oss at buserror.net; Leo Li <leoyang.li@nxp.com>; linux-arm-
> kernel at lists.infradead.org; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>
> Subject: [PATCH 1/2][v6] dt-bindings: mtd-physmap: Add endianness
> supports
> 
> Connection between flash and controller is not necessary to be always of
> same type. It may varies from platform to platform.
> 
> Adding endianness (optional) property to provide connection type
> information.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v2: updated subject
> Changes for v3: fixed typo for "big-endian"
> Changes for v4: Moved binding definition in mtd-physmap.txt as discussed at
> https://patchwork.ozlabs.org/patch/842543/
> Changes for v5: Sending as it is
> Changes for v6: Updated binding when endianness property is absent
> 

I hope this version is good enough to be accepted. 

May I go ahead and send device tree changes for other NXP SoCs.

--pk
