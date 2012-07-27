From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Jul 2012 17:25:09 +0100
Subject: [PATCH 18/24] xen/arm: compile blkfront and blkback
In-Reply-To: <1343382495.6812.127.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-18-git-send-email-stefano.stabellini@eu.citrix.com>
 <1343382495.6812.127.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1207271618310.26163@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jul 2012, Ian Campbell wrote:
> On Thu, 2012-07-26 at 16:34 +0100, Stefano Stabellini wrote:
> > 
> > +#define XEN_IO_PROTO_ABI_ARM        "arm-abi" 
> 
> I wonder if we ought to call this arm-aarch32-abi or something?

So aarch64 has just been renamed to arm64 and you want to rename arm-abi
to aarch32-abi? :-)


> I wonder if we can also take the opportunity to fix the ABI cockup for
> disks on ARM and make the structs the same for both 32 and 64 bit?

I think it should be a separate patch, but I'll try to come up with one
