From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 2 Jan 2014 15:02:19 -0800
Subject: [PATCH] Slightly outdated CONFIG_SMP documentation fix
In-Reply-To: <23596.1388674589@warthog.procyon.org.uk>
References: <20131231225921.GA1624@sylph>
 <23596.1388674589@warthog.procyon.org.uk>
Message-ID: <20140102150219.3df32a23cf7dbe9618ea118e@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 02 Jan 2014 14:56:29 +0000 David Howells <dhowells@redhat.com> wrote:

> Robert Graffham <psquid@psquid.net> wrote:
> 
> > +	  singleprocessor machines. On a singleprocessor machine, the kernel
> 
> "singleprocessor" looks wrong without a hyphen.  How about "uniprocessor"?
> 

Yes please.

Also the patch should have a signed-off-by:, as per
Documentation/SubmittingPatches section 12, please.
