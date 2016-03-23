From: robh@kernel.org (Rob Herring)
Date: Wed, 23 Mar 2016 09:24:00 -0500
Subject: [PATCHv3 6/9] Documentation: dt: socfpga: Add Altera Arria10 L2
 cache binding
In-Reply-To: <1458576106-24505-7-git-send-email-tthayer@opensource.altera.com>
References: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
 <1458576106-24505-7-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160323142400.GA23997@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 11:01:43AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree bindings needed to support the Altera L2
> cache on the Arria10 chip. Since all the peripherals share
> IRQs, the IRQ fields are now in the ecc_manager.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2 Correct spelling of Arria10 in patch title.
> v3 Major restructuring change for ecc_manager to include IRQs
> ---
>  .../bindings/arm/altera/socfpga-eccmgr.txt         |   40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
