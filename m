From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 1 Oct 2012 23:28:09 +0000 (UTC)
Subject: OMAP baseline test results for v3.6-rc7
In-Reply-To: <50645A1D.5040108@compulab.co.il>
References: <alpine.DEB.2.00.1209241919130.25811@utopia.booyaka.com>
 <50645A1D.5040108@compulab.co.il>
Message-ID: <alpine.DEB.2.00.1210012318460.26402@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Sep 2012, Igor Grinberg wrote:

> Have you tried the nohlt boot parameter?
> It looks like the wfi is killing those SoCs once you use EMAC.

Just tried with nohlt.  Didn't help on CM-T3517 with either NFS or MMC 
root, nor with the 3517EVM with NFS root.  But I was able to get the 
3517EVM booting to userspace with MMC root.  Looks like the CM-T3517 board 
file is missing the MMC setup code, so would guess that adding that back 
in would help.


 - Paul
