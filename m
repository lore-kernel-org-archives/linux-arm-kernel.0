From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 10:24:03 -0500
Subject: [PATCH v4 12/23] drivers/fsi: Add documentation for GPIO bindings
In-Reply-To: <20170329174340.89109-13-cbostic@linux.vnet.ibm.com>
References: <20170329174340.89109-1-cbostic@linux.vnet.ibm.com>
 <20170329174340.89109-13-cbostic@linux.vnet.ibm.com>
Message-ID: <20170403152403.uqjtwe33s7s6l7ib@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 12:43:29PM -0500, Christopher Bostic wrote:
> From: Chris Bostic <cbostic@linux.vnet.ibm.com>
> 
> Add fsi master gpio device tree binding documentation
> 
> Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/fsi/fsi-master-gpio.txt    | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt

Acked-by: Rob Herring <robh@kernel.org> 

But what happened to the bus description? There's never a need to 
describe slave devices (even discoverable buses like USB and PCI still 
need them sometimes)? As it stands now, I have no idea what FSI is from 
reading bindings/fsi/*.

Rob
