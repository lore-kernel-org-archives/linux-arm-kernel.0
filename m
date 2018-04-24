From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 24 Apr 2018 11:24:52 +0000
Subject: [PATCHv3 3/7] driver, misc: add Intel Stratix10 service layer
 driver
In-Reply-To: <20180423120300.GC7951@kroah.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
 <1522182014-7338-4-git-send-email-richard.gong@linux.intel.com>
 <20180423120300.GC7951@kroah.com>
Message-ID: <9498165854b84321801d8186d3040b1e@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg KH
> Sent: 23 April 2018 13:03
> On Tue, Mar 27, 2018 at 03:20:10PM -0500, richard.gong at linux.intel.com wrote:
> > +config INTEL_SERVICE
> 
> Naming is hard, but this is a _very_ generic name, don't you agree?
> 
> > +	tristate "Intel Service Layer"
> 
> As is this.  Can you make this a bit more specific to what hardware is
> being controlled here?
> 
> > +++ b/drivers/misc/intel-service.c
> 
> Same for the file name, why not stratix10.c?
> 
> or intel_svc.c?  That makes it a _bit_ more generic.  Well, not really,
> but it does hide the "genericness" a bit more, right?

It'll all be even worse if (when) Intel decide to sell Altera to
someone else.

	David
