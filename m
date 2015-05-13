From: tj@kernel.org (Tejun Heo)
Date: Wed, 13 May 2015 14:10:54 -0400
Subject: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
In-Reply-To: <20150513180705.GZ10428@rric.localhost>
References: <20150513143353.GU11388@htj.duckdns.org>
 <20150513143906.GV11388@htj.duckdns.org>
 <20150513172828.GA8449@rric.localhost>
 <20150513174640.GZ11388@htj.duckdns.org>
 <20150513180705.GZ10428@rric.localhost>
Message-ID: <20150513181054.GB11388@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, May 13, 2015 at 08:07:05PM +0200, Robert Richter wrote:
> So I will move msix after msi then and mark it as a special case if
> msi is not supported. I don't want to move it after intx since this is
> the fallback if nothing else works, there is no explicit check for
> intx, I even don't know if that is possible at all.

Sure, that sounds good to me.

Thanks.

-- 
tejun
