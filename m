From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 18 May 2012 11:56:43 +0200
Subject: [GIT PULL][for 3.5] pull request of board-specific branch in
 arch-pxa git tree
In-Reply-To: <201205151140.07655.arnd@arndb.de>
References: <1337074321.33676.YahooMailClassic@web29011.mail.ird.yahoo.com>
 <201205151140.07655.arnd@arndb.de>
Message-ID: <20120518095643.GG12015@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Paul,

On Tue, May 15, 2012 at 11:40:07AM +0000, Arnd Bergmann wrote:
> On Tuesday 15 May 2012, Paul Parsons wrote:
> > --- On Tue, 15/5/12, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > > 
> > > Did you miss a dependency? Should I revert that patch for
> > > now?
> > 
> > hx4700.c expects to find the clock_rate field in the
> > asic3_platform_data structure.
> > 
> > The clock_rate field is due to be added in V3.5:
> > 
> > http://lkml.indiana.edu/hypermail/linux/kernel/1204.2/00339.html
> > 
> 
> This is not good, you should not split patches in a way that breaks
> the individual pieces. It would have been better to just take the entire
> patch through either arm-soc or the mfd tree.
> 
> Any suggestions for a way out of this mess? I'm inclined to just
> revert the patch I have and let Samuel pick it up to submit it along
> with the other half.
That sounds reasonable. However, it's too late now for a 3.5 inclusion, so
I'll queue it to my for-next branch.
Paul, could you please re-send this patch to me ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
