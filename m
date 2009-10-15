From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 15 Oct 2009 22:45:53 +0100
Subject: [PATCH] s3c: Fix adc function exports
In-Reply-To: <4AD4E230.7080800@bluewatersys.com>
References: <4AD4E096.2060409@bluewatersys.com>
	<20091013201945.GK28849@trinity.fluff.org>
	<4AD4E230.7080800@bluewatersys.com>
Message-ID: <20091015214553.GA2261@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2009 at 09:25:20AM +1300, Ryan Mallon wrote:
> Ben Dooks wrote:
> > On Wed, Oct 14, 2009 at 09:18:30AM +1300, Ryan Mallon wrote:
> >> A couple of mistakes were picked up in the s3c adc driver during the
> >> review of Christian Gagneraud's ep93xx adc patches.
> >  
> >> ---
> >> Make s3c_adc_start static since it is not used by any other driver, and
> >> fix the export of s3c_adc_read.
> > 
> > s3c_adc_start is used by ts driver which is under review, so please don't
> > remove it. The other part is correct, I'll chop and apply.
> 
> Okay, thanks. I take it you are applying to your tree, I don't need to
> fix and submit to the patch system?

I've applied this to next-s3c24xx-fixes, and will try and push it upstream
once I've returned from ELC09 next week.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
