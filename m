From: tj@kernel.org (Tejun Heo)
Date: Fri, 14 Nov 2014 08:08:23 -0500
Subject: [PATCH] ahci_sunxi: Drop AHCI_HFLAG_NO_PMP flag
In-Reply-To: <5465FA40.8000508@redhat.com>
References: <1415874256-6580-1-git-send-email-hdegoede@redhat.com>
 <20141113222952.GI2598@htj.dyndns.org>
 <037f97ce-468b-4b91-9616-51a3301c5be6@googlegroups.com>
 <5465FA40.8000508@redhat.com>
Message-ID: <20141114130823.GA21209@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 01:49:04PM +0100, Hans de Goede wrote:
> > I just found out why Allwinner added that AHCI_HFLAG_NO_PMP flag, after 
> > putting the system I used to test the port multiplexer back together this 
> > morning, it seems that probing for a port multiplexer being present breaks 
> > the no-port-multiplexer (so direct attached disk) case :(  I guess I should 
> > have tested for that before sending the patch, but the thought of it 
> > breaking normal usage did not cross my mind.
> > 
> > So self NACK. If it is not too late, can you please drop this from your 
> > tree ?

I popped the commit from libata/for-3.18-fixes.

Thanks.

-- 
tejun
