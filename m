From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 14 Dec 2010 20:57:58 -0700 (MST)
Subject: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches for
	2.6.38,part two
In-Reply-To: <a52218d5bcff8d959b86230ce9a7ca89@mail.gmail.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
	<a52218d5bcff8d959b86230ce9a7ca89@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1012142057030.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Dec 2010, Rajendra Nayak wrote:

> Boot tested on 2430/3430/4430SDP. Tested RET/OFF mode in suspend
> on 3430SDP with minimal config (omap3_pm_defconfig).

Thanks for testing this.  Would you like me to add Tested-by:'s ?

Also, I still plan to make that change that you proposed to cause the 
prminst, cminst functions to read/write directly to the registers... 
soon...


- Paul
