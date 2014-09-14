From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 14 Sep 2014 18:13:15 +0100
Subject: [PATCH 0/5] m25p80,spi-nor: Fix module aliases for m25p80;
 clean up chip identification
In-Reply-To: <1410714624.3040.38.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
Message-ID: <1410714795.3040.45.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-09-14 at 18:10 +0100, Ben Hutchings wrote:
> The first patch in the series restores the module aliases to m25p80, but
> it does so by duplicating the list of names.  This should be suitable
> for stable, but it isn't viable in the longer term.
> 
> The following patches change the spi-nor interface so that this
> duplication is no longer necessary.  This includes removing
> spi_nor::read_id, but it could be re-added after this with a different
> interface, e.g. returning a flash_info structure (which would need to be
> defined in spi_nor.h).

Note that these patch are:
- Based on your 'testing' branch
- Untested by me, aside from compiling and checking that m25p80 has the
  expected module aliases

Ben.

-- 
Ben Hutchings
The world is coming to an end.	Please log off.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140914/5e97912a/attachment-0001.sig>
