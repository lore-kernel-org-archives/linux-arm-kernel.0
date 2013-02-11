From: mgreer@animalcreek.com (Mark A. Greer)
Date: Mon, 11 Feb 2013 11:07:47 -0700
Subject: [PATCH 03/15] ARM: OMAP3xxx: hwmod: Convert SHAM crypto device
 data to hwmod
In-Reply-To: <alpine.DEB.2.00.1302081630150.28008@utopia.booyaka.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <1356107295-11121-4-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1302081630150.28008@utopia.booyaka.com>
Message-ID: <20130211180747.GB27656@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 05:42:13PM +0000, Paul Walmsley wrote:
> Hi Mark,
> 
> On Fri, 21 Dec 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > Convert the device data for the OMAP3 SHAM2 (SHA1/MD5) crypto IP
> > from explicit platform_data to hwmod.
> > 
> > CC: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> This one has been updated here to split the OMAP3xxx GP hwmod lists, as we 
> discussed.  Updated patch follows.

Thanks Paul.
