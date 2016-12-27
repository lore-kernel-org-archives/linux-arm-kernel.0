From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Dec 2016 09:30:15 -0800
Subject: [PATCH 0/9] ARM: omap: Add empty chosen node in SoCs top level
 DTSI
In-Reply-To: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
References: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20161227173015.GP4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@osg.samsung.com> [161219 06:45]:
> Hello Tony,
> 
> As discussed in [0], there's a regression when booting a kernel with a DTB
> that doesn't have a pre-existing chosen node. This is usually not an issue
> for most boards since u-boot creates an empty chosen node if isn't present
> in the DTB.
> 
> But it can be an issue for others bootloaders as Pali pointed out with the
> N9/900/950 phones and the Nokia Loader (NoLo).
> 
> This patch series add chosen nodes in the top level DTSI for all OMAP SoCs.
> 
> [0]: http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1294379.html

Applying these into omap-for-v4.10/fixes thanks.

Tony
