From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Jan 2014 06:32:08 -0800
Subject: NFS client broken in Linus' tip
In-Reply-To: <20140130142752.GX15937@n2100.arm.linux.org.uk>
References: <20140130140834.GW15937@n2100.arm.linux.org.uk>
 <20140130141405.GA23985@infradead.org>
 <20140130142752.GX15937@n2100.arm.linux.org.uk>
Message-ID: <20140130143208.GB9573@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 02:27:52PM +0000, Russell King - ARM Linux wrote:
> Yes and no.  I still end up with an empty /etc/mtab, but the file now
> exists.  However, I can create and echo data into /etc/mtab, but it seems
> that can't happen at boot time.

Odd.  Can you disable CONFIG_NFSD_V3_ACL for now to isolate the issue?

I'll be out for a long weekend soon, so I have very limited time to
debug things until Monday.
