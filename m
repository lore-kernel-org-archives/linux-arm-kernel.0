From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 20:56:06 +0200
Subject: [RFC PATCH 01/11] dma: amba-pl08x: Use bitmap to pass variant
 specific quirks
In-Reply-To: <20130617184856.GN2718@n2100.arm.linux.org.uk>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-2-git-send-email-tomasz.figa@gmail.com>
 <20130617184856.GN2718@n2100.arm.linux.org.uk>
Message-ID: <12368941.dQe8bcScGj@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 of June 2013 19:48:56 Russell King - ARM Linux wrote:
> On Sun, Jun 16, 2013 at 10:54:08PM +0200, Tomasz Figa wrote:
> > Instead of defining new bool field in vendor_data struct for each
> > quirk, it is more reasonable to use a single flags field and make
> > each quirk use single bits.
> 
> Please explain why this is better over the existing system, and why it
> is not just churn for code modification's sake.

It isn't anything important. I just thought that this is a better solution 
to store more than just two flags. Initially I had more of them added in 
further patches, but final version ended with just one, so this can be 
dropped.

Best regards,
Tomasz
