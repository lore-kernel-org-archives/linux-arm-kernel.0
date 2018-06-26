From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Jun 2018 15:12:03 -0600
Subject: [PATCH 1/2] Documentation: dt: keystone: ti-sci: Add optional
 host-id parameter
In-Reply-To: <20180619194421.3432-2-nm@ti.com>
References: <20180619194421.3432-1-nm@ti.com> <20180619194421.3432-2-nm@ti.com>
Message-ID: <20180626211203.GA19874@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 02:44:20PM -0500, Nishanth Menon wrote:
> Texas Instrument's System Control Interface (TISCI) permits
> the ability for OSs running in virtual machines to be able to
> independently communicate with the firmware without the need going
> through an hypervisor.
> 
> The "host-id" in effect is the hardware representation of the
> host (example: VMs locked to a core) as identified to the System
> Controller. Hypervisors can either fill in appropriate host-ids in dt
> used for each VM instance OR may use prebuilt blobs where the host-ids
> are pre-populated, as appropriate for the OS running in the VMs.
> 
> This is introduced as an optional parameter to maintain consistency
> with legacy device tree blobs.
> 
> We call this with a vendor prefix to prevent any possible confusion
> with SCSI ID (m68k) kernel option.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since RFC:
> * Commit message update to elaborate usage in VM
> 
> RFC: https://patchwork.kernel.org/patch/10447753/
> 
>  Documentation/devicetree/bindings/arm/keystone/ti,sci.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
