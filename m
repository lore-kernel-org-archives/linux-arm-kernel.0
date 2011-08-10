From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 10 Aug 2011 00:08:28 -0600 (MDT)
Subject: How to handle named resources with DT?
In-Reply-To: <20110810012958.GB23511@yookeroo.fritz.box>
References: <4E40FC88.5090403@ti.com>
	<20110809162907.GA630@manju-WNB7PBC4801-0006>
	<4E4166F0.9050401@ti.com>
	<CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
	<20110810012958.GB23511@yookeroo.fritz.box>
Message-ID: <alpine.DEB.2.00.1108092351390.12674@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Aug 2011, David Gibson wrote:

> The difficulty with adding th enames to the DT itself is that it
> exposes the essentially Linux-specific names in what's supposed to be
> an OS neutral data structure.

The names are supposed to pertain to the hardware IP block, not the OS.  
See for example [1] and [2].  

If there's something OS-specific about the names, then the data isn't 
right.


- Paul

1. http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod_44xx_data.c;h=6201422c0606b5103c01e563f67060134658774d;hb=322a8b034003c0d46d39af85bf24fee27b902f48#l2359

2. Table 23-13 "HS I?C DMA Requests", OMAP4430 TRM version V 
   (SWPU231V), available from 
   http://focus.ti.com/pdfs/wtbu/OMAP4430_ES2.x_PUBLIC_TRM_vV.zip 
