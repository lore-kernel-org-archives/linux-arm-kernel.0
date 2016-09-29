From: horms@verge.net.au (Simon Horman)
Date: Thu, 29 Sep 2016 09:40:00 +0200
Subject: [PATCH v6 0/3] arm64 kexec-tools patches
In-Reply-To: <f1331028-e20b-50a3-fdeb-1e24861c7f29@suse.com>
 <20160923085840.GA22928@localhost.localdomain>
Message-ID: <20160929074000.GB14497@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 06:05:14PM +0200, Matthias Brugger wrote:
> 
> 
> On 21/09/16 20:14, Geoff Levand wrote:
> >This series adds the core support for kexec re-boot on ARM64.
> >
> 
> I also tested on seattle.
> 
> Tested-By: Matthias Brugger <mbrugger@suse.com>

On Fri, Sep 23, 2016 at 02:28:40PM +0530, Pratyush Anand wrote:
> Hi Geoff,
> 
> On 21/09/2016:06:14:25 PM, Geoff Levand wrote:
> > This series adds the core support for kexec re-boot on ARM64.
> 
> I tested this series with mustang and seattle and they work.
> 
> So you can use my "Tested-By: Pratyush Anand <panand@redhat.com>".
> 
> Just one Nitpick: In patch 2/3 arm64_header_check_msb(),
> arm64_header_page_size() and arm64_header_placement() have been defined but they
> have not been used anywhere. So, may be they can be removed.

Thanks everyone, I have queued this up with the above tags.

Please consider a follow-up patch to remove the functions mentioned above.

FWIW I tested v5 of this patchset on Renesas Gen3 R-Car H3 and M3-W and
it seems to work fine.
