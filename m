From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Sep 2012 15:00:52 +0000
Subject: [PATCH v3 1/1] arm: introduce a DTS for Xen unprivileged virtual
 machines
In-Reply-To: <1348483574-7901-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <1348483574-7901-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <201209241500.53229.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 September 2012, Stefano Stabellini wrote:
> Given that the xenvm machine is based on vexpress but with an extremely
> limited selection of peripherals (the guest is supposed to use virtual
> devices instead), add "xen,xenvm" to the list of compatible machines in
> mach-vexpress.
> 
> 
> Changes in v3:
> 
> - add comments to mark fields that are likely to be changed by the
> hypervisor.
> 
> 
> Changes in v2:
> 
> - remove include skeleton;
> - use #address-cells = <2> and #size-cells = <2>;
> - remove the debug bootargs;
> - use memory at 80000000 instead of memory;
> - remove the ranges and interrupt-map from the motherboard node;
> - set the machine compatible to "xen,xenvm-4.2", "xen,xenvm";
> - rename the dts file to xenvm-4.2.dts;
> - add "xen,xenvm" to the list of compatible DT strings to mach-vexpress.
> 
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Acked-by: Pawel Moll <pawel.moll@arm.com> (v2m changes)
> CC: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
