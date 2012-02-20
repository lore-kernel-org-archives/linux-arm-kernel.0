From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 20 Feb 2012 17:50:53 +0100
Subject: mc13xxx: add I2C support
In-Reply-To: <201201201855.35971.marc@cpdesign.com.au>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <87lip4kktc.fsf@lebrac.rtp-net.org>
 <20120119112941.GC29494@sirena.org.uk>
 <201201201855.35971.marc@cpdesign.com.au>
Message-ID: <20120220165053.GA5387@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Fri, Jan 20, 2012 at 06:55:35PM +1100, Marc Reilly wrote:
> Hi,
> 
> Thankyou all for your feedback and comments. I'll use them for a V2 but 
> Samuel, I'd like to know if you'd like me to base them on a specific branch 
> before I do.
Please rebase it against my for-next branch.


> Shawn, thanks for testing!
> 
> On Thursday, January 19, 2012 10:29:41 PM Mark Brown wrote:
> > On Thu, Jan 19, 2012 at 12:12:31PM +0100, Arnaud Patard wrote:
> > > I've never looked at regmap deeply but can't it be done with regmap or is
> > > it just a bad idea ?
> > 
> > Glancing quickly at the existing code it should map on reasonably well,
> > though a new format definition may be required for the 25 bit shift that
> > would be trivial.
> 
> I'm sadly unfamiliar with regmap, is it a far superior solution? does it need 
> to used now? (ie. I'm relucant to totally rework this now. Please convince me 
> I need to if required.)
I think Mark exposed the advantages of using regmap. It's not a mandatory API
usage at that point, but since we still have about 4 weeks before the next
merge window opens, and since the changes wouldn't be a huge piece of work,
I'd recommend switching to it now.

Cheers,
Samuel. 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
