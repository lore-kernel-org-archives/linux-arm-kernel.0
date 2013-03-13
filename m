From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 13 Mar 2013 10:22:17 +0000 (UTC)
Subject: OMAP baseline test results for v3.9-rc1
In-Reply-To: <51402BE9.5040402@compulab.co.il>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
 <51402BE9.5040402@compulab.co.il>
Message-ID: <alpine.DEB.2.00.1303131020270.32131@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On Wed, 13 Mar 2013, Igor Grinberg wrote:

> This should have been fixed by:
> ff95793 (ARM: OMAP3: cm-t3517: add MMC support)
> 
> I also can't find the MMC rootfs boot log on your website.

Hmm, I thought I had switched the CM-T3517 over to use MMC booting, but 
looks like it's still trying to use nfsroot.  Thanks for letting me know.  
Will switch to MMC and try again.


- Paul
