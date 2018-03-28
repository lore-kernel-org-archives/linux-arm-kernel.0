From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Wed, 28 Mar 2018 09:48:08 +0000
Subject: [PATCH 1/2][v7] dt-bindings: mtd-physmap: Add endianness supports
In-Reply-To: <20180328103001.6f4b16d9@bbrezillon>
References: <20180328054443.2829-1-prabhakar.kushwaha@nxp.com>
 <20180328103001.6f4b16d9@bbrezillon>
Message-ID: <VI1PR0402MB3854A5A7E389D80CCEF0197997A30@VI1PR0402MB3854.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> Sent: Wednesday, March 28, 2018 2:00 PM
> To: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> Cc: linux-mtd at lists.infradead.org; devicetree at vger.kernel.org;
> mark.rutland at arm.com; robh at kernel.org; boris.brezillon at free-electrons.com;
> Poonam Aggrwal <poonam.aggrwal@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> oss at buserror.net; computersforpeace at gmail.com; shawnguo at kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2][v7] dt-bindings: mtd-physmap: Add endianness
> supports
> 
> On Wed, 28 Mar 2018 11:14:43 +0530
> Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com> wrote:
> 
> > Connection between flash and controller is not necessary to be always
> > of same type. It may varies from platform to platform.
> >
> > Adding endianness (optional) property to provide connection type
> > information.
> 
> You forgot to adjust your commit message.
> 
> If you're okay, I'll replace your message by:
> 
> "
> Provides a way to specify the endianness to use when accessing a memory-
> mapped flash.
> "
> 

Thanks for catching this. Please adjust as you suggested.

--prabhakar
