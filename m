From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 12 Dec 2011 14:06:51 +0000
Subject: [PATCH v5 5/9] ARM: versatile: Map local timers using Device
 Tree when possible
In-Reply-To: <20111212140459.GX14542@n2100.arm.linux.org.uk>
References: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
 <1323457432-4800-6-git-send-email-pawel.moll@arm.com>
 <20111212140459.GX14542@n2100.arm.linux.org.uk>
Message-ID: <1323698811.2391.60.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-12-12 at 14:04 +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 09, 2011 at 07:03:48PM +0000, Pawel Moll wrote:
> > If twd_base is not set, try to map the TWD registers from
> > "arm,smp-twd" Device Tree node (compatible value as used in
> > Highbank's DT).
> 
> Please do it the other way around - allow DT to override twd_base if
> the DT node is present.

Ok, will do.

Thanks!

Pawe?
