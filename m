From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Oct 2012 11:47:00 +0000 (UTC)
Subject: OMAP baseline test results for v3.7-rc3
In-Reply-To: <508FB226.20604@mimc.co.uk>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
Message-ID: <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc Vaibhav Hiremath

On Tue, 30 Oct 2012, Mark Jackson wrote:

> At what point is booting from MMC on the BeagleBone going to start working ?
> 
> I only ask, since, by default, a new BeagleBone is setup to boot from 
> MMC, so anyone testing a new kernel will probably expect the same setup 
> to work.

BeagleBone boots initramfs from MMC now, which is what mine was shipped to 
do.  Are you asking about rootfs on MMC?  If so, Vaibhav would have a 
better sense of this than I.


- Paul
