From: hemantp@ti.com (Pedanekar, Hemant)
Date: Thu, 15 Sep 2011 07:11:37 +0530
Subject: [RFC PATCH v2 0/6] TI81XX: Add clock and hwmod data
In-Reply-To: <20110915003325.GD30941@atomide.com>
References: <1314119594-22647-1-git-send-email-hemantp@ti.com>
	<alpine.DEB.2.00.1108301246170.26173@utopia.booyaka.com>
	<20110915003325.GD30941@atomide.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4BF4747@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote on Thursday, September 15, 2011 6:03 AM:

> * Paul Walmsley <paul@pwsan.com> [110830 11:13]:
>> On Tue, 23 Aug 2011, Hemant Pedanekar wrote:
>> 
>>> This patch set is the v2 of TI816X clock and hwmods patches sent earlier.
>>> 
>>> The clock data is currently added only for TI816X, while minimal hwmod
>>> data common for TI816X and TI814X is added.
>>> 
>>> This patch set depends on following patches:
>>> 	TI81XX: Prepare for addition of TI814X support
>>> 	TI814X: Add cpu type macros and detection support
>>> 	TI814X: Create board support and enable build for TI8148 EVM
>>> 
>>> Please note that CHIP_IS_TI816X/CHIP_IS_TI814X are still being used and I
>>> will send update once SoC list usage is available.
>> 
>> Thanks - am working away on these patches & hope to have them out soon.
> 
> Hemant, can you please rebase your patches on Paul's CHIP_IS removal branch?
> 
> It's available at:
> 
> git://git.pwsan.com/linux-2.6 omap_chip_remove_cleanup_3.2
> 
> Regards,
> 
> Tony

Thanks, I will do that and send v3.

   Hemant
