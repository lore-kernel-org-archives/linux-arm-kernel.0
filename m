From: greg@kroah.com (Greg KH)
Date: Wed, 13 Apr 2011 14:00:57 -0700
Subject: [RFC][PATCH V4] axi: add AXI bus driver
In-Reply-To: <BANLkTimBZK8i3EgihB85HqTJ+wOz89uwTw@mail.gmail.com>
References: <1302634375-2378-1-git-send-email-zajec5@gmail.com>
	<20110413163113.GA24015@kroah.com>
	<BANLkTin-4HrJzNrLOxRy_-a98S3ZF4aSQw@mail.gmail.com>
	<BANLkTimBZK8i3EgihB85HqTJ+wOz89uwTw@mail.gmail.com>
Message-ID: <20110413210057.GA7523@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 10:37:44PM +0200, G?bor Stefanik wrote:
> On Wed, Apr 13, 2011 at 9:39 PM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> > Hm, I'm not sure. Using EXPORT_SYMBOL_GPL will forbid closed source
> > drivers from using our bus driver, right? I'm don't have preferences
> > on this, if you prefer us to force GPL, I can.
> 
> Isn't EXPORT_SYMBOL_GPL for symbols that are considered to form a
> tight coupling between the kernel and users of the symbol? Using _GPL
> just because you are against proprietary drivers in general and want
> to force GPL on HW vendors is wrong.

It shows _intent_.  Not to say that functions that are not exported in
this manner do not also require only GPL kernel code to be used as well
at all.

See the archives for more details if you are curious about it, it's been
covered numerous times in the past.

thanks,

greg k-h
