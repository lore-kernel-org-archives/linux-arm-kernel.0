From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 26 Apr 2012 16:56:39 -0600 (MDT)
Subject: [PATCH v2] arm: omap3: am35x: Fix clockdomain dependencies
In-Reply-To: <1334866606-8291-1-git-send-email-mgreer@animalcreek.com>
References: <1334866606-8291-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1204261656160.10308@utopia.booyaka.com>
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

Thanks, queued for 3.5.


- Paul
