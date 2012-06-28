From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 28 Jun 2012 00:08:13 -0600 (MDT)
Subject: [PATCH v2] arm: omap3: am35x: Fix clockdomain dependencies
In-Reply-To: <1334866606-8291-1-git-send-email-mgreer@animalcreek.com>
References: <1334866606-8291-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1206280007420.2338@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs do not have an IVA so
> a parallel set of clockdomain dependencies are
> required that are simililar to OMAP3 but without
> any IVA dependencies.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
> 
> Paul, this is a respin of
> 	"[PATCH 08/12] arm: omap3: am35x: Fix clockdomain dependencies"
> 
> with your comments [hopefully] addressed.  I'm breaking that long series
> into smaller pieces because most of them really weren't related.

Thanks, queued for 3.6.


- Paul
