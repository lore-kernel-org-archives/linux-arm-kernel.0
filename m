From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Dec 2011 21:25:21 +0000
Subject: [PATCH-RFC 04/10] arm: switch to GENERIC_PCI_IOMAP
In-Reply-To: <20111204104709.GF15464@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <1415bf8cf7d98d05b7d189e913efb7f9668846ac.1322163031.git.mst@redhat.com>
 <20111204104709.GF15464@redhat.com>
Message-ID: <20111204212521.GA14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 04, 2011 at 12:47:09PM +0200, Michael S. Tsirkin wrote:
> On Thu, Nov 24, 2011 at 10:17:42PM +0200, Michael S. Tsirkin wrote:
> > arm copied pci_iomap from generic code, probably to avoid
> > pulling the rest of iomap.c in.  Since that's in
> > a separate file now, we can reuse the common implementation.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> Sorry to nag, any ACKs/NACKs on the arm part?
> I intend to send this to Linus if there are no
> objections. Thanks!

As there's no difference between the generic version and this version
you're removing...

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
