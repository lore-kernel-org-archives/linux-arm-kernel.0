From: emunson@akamai.com (Eric B Munson)
Date: Fri, 24 Jul 2015 10:39:36 -0400
Subject: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
In-Reply-To: <20150723065830.GA5919@linux-mips.org>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
 <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
 <1437528316.16792.7.camel@ellerman.id.au>
 <20150722141501.GA3203@akamai.com>
 <20150723065830.GA5919@linux-mips.org>
Message-ID: <20150724143936.GE9203@akamai.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Jul 2015, Ralf Baechle wrote:

> On Wed, Jul 22, 2015 at 10:15:01AM -0400, Eric B Munson wrote:
> 
> > > 
> > > You haven't wired it up properly on powerpc, but I haven't mentioned it because
> > > I'd rather we did it.
> > > 
> > > cheers
> > 
> > It looks like I will be spinning a V5, so I will drop all but the x86
> > system calls additions in that version.
> 
> The MIPS bits are looking good however, so
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> With my ack, will you keep them or maybe carry them as a separate patch?

I will keep the MIPS additions as a separate patch in the series, though
I have dropped two of the new syscalls after some discussion.  So I will
not include your ack on the new patch.

Eric
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/318afb28/attachment.sig>
