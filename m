From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2011 22:41:29 +0000
Subject: [PATCH] arm: omap2+: hwmod: fix breakage introduced by d6504acd
In-Reply-To: <alpine.DEB.2.00.1111071428001.12394@utopia.booyaka.com>
References: <1320688617-4543-1-git-send-email-balbi@ti.com>
 <20111107183208.GG15294@n2100.arm.linux.org.uk>
 <20111107193908.GA5059@legolas.emea.dhcp.ti.com>
 <20111107212707.GH15294@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1111071428001.12394@utopia.booyaka.com>
Message-ID: <20111107224129.GJ15294@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 02:29:35PM -0700, Paul Walmsley wrote:
> On Mon, 7 Nov 2011, Russell King - ARM Linux wrote:
> 
> > Again, can never have been tested on OMAP3.
> > 
> > Does anyone apart from me bother doing any testing what so ever on OMAP3
> > platforms?  Am I the only one?
> 
> This was fixed by 
> 
> http://www.spinics.net/lists/arm-kernel/msg143549.html
> 
> which didn't go upstream as part of the v3.2 merge window.

Ah, that patch.

Which version of the patch does Tony have?  The one you point at which
uses IS_ERR_VALUE() and I complained about, or the version that has that
fixed?
