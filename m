From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Dec 2016 11:50:01 +0000
Subject: [Xen-devel] [PATCH v2 4/4] Explicitly clean linux-system.axf and
 xen-system.axf
In-Reply-To: <cb5e65ca-65a2-6e0c-47f5-1773d6173739@arm.com>
References: <20161122150917.16524-1-andre.przywara@arm.com>
 <20161122150917.16524-5-andre.przywara@arm.com>
 <20161212144729.GD1686@char.us.oracle.com>
 <cb5e65ca-65a2-6e0c-47f5-1773d6173739@arm.com>
Message-ID: <20161215115000.GB21758@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2016 at 02:50:20PM +0000, Andre Przywara wrote:
> Hi Konrad,
> 
> On 12/12/16 14:47, Konrad Rzeszutek Wilk wrote:
> > On Tue, Nov 22, 2016 at 03:09:17PM +0000, Andre Przywara wrote:
> >> From: Christoffer Dall <christoffer.dall@linaro.org>
> >>
> >> When doing a make clean, only the output image currently configured to
> >> build is being removed.  However, one would expect all build artifacts
> >> to be removed when doing a 'make clean' and when switching between Xen
> >> and Linux builds, it is easy to accidentally run an older build than
> >> intended.  Simply hardcode the axf image file names.
> >>
> >> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> Reviewed-by: Julien Grall <julien.grall@arm.com>
> > 
> > Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Thanks a lot!
> 
> I will try to poke Mark to see if we can get this merged eventually.

I'm happy to take these so long as this doesn't adversely affect non-Xen
usage. I assume they don't. :)

Could you fix this up as per Julien's comments, and fold in the tags?
I'm happy to take that from a v3 or a git repo.

Thanks,
Mark.
