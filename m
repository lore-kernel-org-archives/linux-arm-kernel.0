From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 11 Sep 2015 12:00:00 +0100
Subject: [PATCH] efi/libstub/fdt: Standardize the names of EFI stub
 parameters
In-Reply-To: <alpine.DEB.2.02.1509101655020.2672@kaball.uk.xensource.com>
References: <1441874516-11364-1-git-send-email-zhaoshenglong@huawei.com>
 <20150910095208.GA29293@leverpostej>
 <alpine.DEB.2.02.1509101116580.2672@kaball.uk.xensource.com>
 <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
 <20150910121514.GE29293@leverpostej>
 <alpine.DEB.2.02.1509101429480.2672@kaball.uk.xensource.com>
 <20150910144938.GI29293@leverpostej>
 <alpine.DEB.2.02.1509101655020.2672@kaball.uk.xensource.com>
Message-ID: <1441969200.3549.23.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-09-10 at 17:10 +0100, Stefano Stabellini wrote:

> > C) When you could go:
> > 
> >    DT -> Discover Xen -> Xen-specific stuff -> Xen-specific EFI/ACPI
> > discovery
> 
> I take you mean discovering Xen with the usual Xen hypervisor node on
> device tree.

There may be other options, such as ARM defining an architectural mechanism
to do early detection of hypervisors e.g. by defining some bit in some
hypervisor controllable register (MPIDR?) to say "a hypervisor is present"
and defining an hvc or smc call which can be used to ask which one it is.

Ian.
