From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 5 Aug 2016 19:30:11 +0530
Subject: [PATCH] ARM: dts: da850: Add basic DTS for the L138/C6748 Dev Kit
In-Reply-To: <m2popopcqu.fsf@baylibre.com>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <m2popopcqu.fsf@baylibre.com>
Message-ID: <57A49BEB.7070503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 August 2016 12:45 AM, Kevin Hilman wrote:
>>  Documentation/devicetree/bindings/arm/davinci.txt |  4 ++
>>  arch/arm/boot/dts/Makefile                        |  1 +
>>  arch/arm/boot/dts/omapl138-lcdk.dts               | 71 +++++++++++++++++++++++
> 
> I think this should be called da850-lcdk.dts.
> 
> The OMAP prefix in the DT directory is just going to cause confusion,
> and the other DTs using this same SoC are already called da850.
> 
> Sekhar do you have any opinion here?

Prefer using da850 in file names and in code. The explanatory or help
text can contain rest of the part names.

For file names or code catering both to da850 and da830, da8xx should be
used.

I know documentation for da850 and da830 is not public, but thats what
the parts first came out as, and we want to be consistent with existing
code.

Regards,
Sekhar
