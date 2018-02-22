From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 22 Feb 2018 07:54:55 +0100
Subject: [PATCH v2 1/8] [PATCH 1/8] drivers/peci: Add support for PECI
 bus driver core
In-Reply-To: <7f152459-a232-e62a-3c34-e995f8c85d63@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
 <20180221175853.GA22320@kroah.com>
 <7f152459-a232-e62a-3c34-e995f8c85d63@linux.intel.com>
Message-ID: <20180222065455.GA2428@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 12:42:30PM -0800, Jae Hyun Yoo wrote:
> On 2/21/2018 9:58 AM, Greg KH wrote:
> > On Wed, Feb 21, 2018 at 08:15:59AM -0800, Jae Hyun Yoo wrote:
> > > This commit adds driver implementation for PECI bus into linux
> > > driver framework.
> > > 
> > > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > > ---
> > 
> > Why is there no other Intel developers willing to review and sign off on
> > this patch?  Please get their review first before asking us to do their
> > work for them :)
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Hi Greg,
> 
> This patch set got our internal review process. Sorry if it's code quality
> is under your expectation but it's the reason why I'm asking you to review
> the code. Could you please share your time to review it?

Nope.  If no other Intel developer thinks it is good enough to put their
name on it as part of their review process, why should I?

Again, please use the resources you have, to fix the obvious problems in
your code, BEFORE asking the community to do that work for you.

greg k-h
