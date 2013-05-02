From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 May 2013 19:05:35 +0100
Subject: [PATCH -v7 0/11] Shutdown from reboot_cpuid without stopping
 other cpus.
In-Reply-To: <20130502033952.GU3658@sgi.com>
References: <1367428011-17123-1-git-send-email-holt@sgi.com>
 <20130501231347.GT14496@n2100.arm.linux.org.uk>
 <20130502033952.GU3658@sgi.com>
Message-ID: <20130502180535.GZ14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 10:39:52PM -0500, Robin Holt wrote:
> On Thu, May 02, 2013 at 12:13:47AM +0100, Russell King - ARM Linux wrote:
> > On Wed, May 01, 2013 at 12:06:40PM -0500, Robin Holt wrote:
> > > Andrew, Please do _NOT_ take this patch series yet.  I am sending this
> > > to you because you had comments on my -v6 submission.
> > 
> > Another reason for not applying this is that I believe it wilfully breaks
> > a bunch of ARM platforms - such as removing the 'g' reboot mode (for gpio
> > based reboot on PXA), and removing the 's' reboot mode off a bunch of ARM
> > platforms which have no way to do a hard reboot.
> 
> I am not sure what your basis for this statement is.

Probably old understanding of the code, and me getting old and getting
forgetful. :(
