From: hemantp@ti.com (Pedanekar, Hemant)
Date: Thu, 4 Aug 2011 22:53:57 +0530
Subject: [PATCH 1/2] TI816X: Add minimal hwmod data
In-Reply-To: <alpine.DEB.2.00.1107160139470.25013@utopia.booyaka.com>
References: <1303922002-6946-1-git-send-email-hemantp@ti.com>
	<alpine.DEB.2.00.1104281634050.11487@utopia.booyaka.com>
	<5F744A5A3C131242B81CE5874BD2CFFBBF8F8F14@dlee01.ent.ti.com>
	<alpine.DEB.2.00.1104282058370.11487@utopia.booyaka.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03AB5FAAAB@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1107160139470.25013@utopia.booyaka.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABA7E9F8@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Paul Walmsley wrote on Saturday, July 16, 2011 1:38 PM:

> Hello Hemant,
> 
> On Wed, 13 Jul 2011, Pedanekar, Hemant wrote:
> 
>> Any comments on the hwmod and clock patch sets?
> 
> I haven't forgotten about these patches.
> 
> Here are a few questions:
>
Sorry I missed this mail.
 
> - Are there are public documents about what interconnect is
> used on these
> chips?  Is it a SonicsMX, an Arteris NOC, or something else?
>
I will get back to you on this.
 
> - It looks like you've grouped the PRCM implementation with
> the existing
> OMAP3 PRCM code.  But it appears to me, looking at the 816X
> TRM, that the
> register layout is closer to OMAP4 - the MODULEMODE bits, etc.  Any
> comments on this? 
>

You are correct. The register layout is closer to OMAP4 hence I have
Used ".omap4" from PRCM data union field in struct omap_hwmod  for
Hwmod data. 

Thanks.

   Hemant
