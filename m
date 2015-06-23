From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 23 Jun 2015 16:02:47 +0100
Subject: [Xen-devel] [RFC 23/23] arm/xen: Add support for 64KB page
 granularity
In-Reply-To: <alpine.DEB.2.02.1506231545370.18681@kaball.uk.xensource.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-24-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1506231508050.16917@kaball.uk.xensource.com>
 <55896F2D.5030405@citrix.com>
 <alpine.DEB.2.02.1506231545370.18681@kaball.uk.xensource.com>
Message-ID: <55897517.9000306@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/06/15 15:49, Stefano Stabellini wrote:
> Yes, you are right, I was reading an older version of Linux that still
> had xen_remap_domain_mfn_range properly implemented.
> 
> The new function is called xen_remap_domain_mfn_array which calls
> xen_xlate_remap_gfn_array.
> 
> I'll rephrase my question then: What about xen_remap_domain_mfn_array? I
> guess we don't support that use case on 64K guests? If so, I would
> appreaciate an assert and/or an error message.

See https://lkml.org/lkml/2015/5/14/563

-- 
Julien Grall
