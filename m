From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 9 Dec 2010 10:41:01 -0700 (MST)
Subject: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches for
	2.6.38, part two
In-Reply-To: <20101209161932.4f4aae76.jhnikula@gmail.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
	<20101209161932.4f4aae76.jhnikula@gmail.com>
Message-ID: <alpine.DEB.2.00.1012091038420.13430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jarkko

On Thu, 9 Dec 2010, Jarkko Nikula wrote:

> On Tue, 07 Dec 2010 23:18:28 -0700
> Paul Walmsley <paul@pwsan.com> wrote:
> 
> > This series is available via git from git://git.pwsan.com/linux-2.6 in
> > the branch 'pwrdm_prcm_b_2.6.38'.  It applies on top of the "OMAP:
> > PRCM/powerdomain/clockdomain patches for 2.6.38, part one" series,
> > sent earlier.
> > 
> > Kevin and OMAP ASoC-hackers, I'd appreciate review and acks, if
> > appropriate, on the patches that touch code that you maintain.  TI
> > OMAP4 PM people, I would appreciate any testing assistance that you
> > may be able to provide.  Beno?t, I've tried to keep the kernel data
> > files and the output of the scripts relatively similar, but we might
> > need to do some tweaking of the scripts or data files to align them
> > in the way that makes the most sense.
> > 
> Is there some patch missing? Part one compiles but this set does not.

Yes, mach-omap2/cminst44xx.h is missing from the posted series.  It's been 
added to the branch on the git server and posted here:

http://www.spinics.net/lists/arm-kernel/msg106850.html

Will repost the updated series after handling some of the other comments.


- Paul
