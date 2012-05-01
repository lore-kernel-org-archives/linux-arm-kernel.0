From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 1 May 2012 12:39:49 +0200
Subject: mc13xxx: add I2C support, V5
In-Reply-To: <201204170921.42027.marc@cpdesign.com.au>
References: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
 <201204170921.42027.marc@cpdesign.com.au>
Message-ID: <20120501103949.GC20224@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, Apr 17, 2012 at 09:21:41AM +1000, Marc Reilly wrote:
> Hi Samuel,
> 
> 
> On Sunday, April 01, 2012 04:41:35 PM Marc Reilly wrote:
> > This series (against mfd-2.6/for-next) changes the mc13xxx driver to use
> > regmap and adds I2C support.
> > It has a compile dependency on regmap/for-next, as the spi driver uses the
> > recently added pad_bits config field.
> 
> (bump).
> 
> Are these changes OK to go in?
All 4 patches applied to my for-next branch.
I had to manually apply patch #1, please verify that it's all good.
I added an Acked-by: Oskar Schirmer <oskar@scara.com> to patch #4. Please make
sure that you add the right tags to the corresponding patches in the future.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
