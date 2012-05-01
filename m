From: marc@cpdesign.com.au (Marc Reilly)
Date: Wed, 2 May 2012 08:55:55 +1000
Subject: mc13xxx: add I2C support, V5
In-Reply-To: <20120501103949.GC20224@sortiz-mobl>
References: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
 <201204170921.42027.marc@cpdesign.com.au>
 <20120501103949.GC20224@sortiz-mobl>
Message-ID: <201205020855.55953.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

> > On Sunday, April 01, 2012 04:41:35 PM Marc Reilly wrote:
> > > This series (against mfd-2.6/for-next) changes the mc13xxx driver to
> > > use regmap and adds I2C support.
> > > It has a compile dependency on regmap/for-next, as the spi driver uses
> > > the recently added pad_bits config field.
> > 
> > (bump).
> > 
> > Are these changes OK to go in?
> 
> All 4 patches applied to my for-next branch.
> I had to manually apply patch #1, please verify that it's all good.

Looks good. I think I can see where it didn't apply, thanks for that. 

> I added an Acked-by: Oskar Schirmer <oskar@scara.com> to patch #4. Please
> make sure that you add the right tags to the corresponding patches in the
> future.
Apologies, will try.

Cheers,
Marc
