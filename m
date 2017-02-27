From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 08:49:48 -0600
Subject: [PATCH v3 2/6] ARM: dts: armada-xp-98dx3236: combine dfx server
 nodes
In-Reply-To: <20170216085041.28337-3-chris.packham@alliedtelesis.co.nz>
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
 <20170216085041.28337-3-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170227144948.arndiwidghwd7pth@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 09:50:36PM +1300, Chris Packham wrote:
> Rather than having a separate node for the dfx server add a reg property
> to the parent node. This give some compatibility with the Marvell
> supplied SDK.
> 
> As no upstream driver currently exists for this block and support for
> this SoC is still quite fresh in the kernel it should not be necessary
> to retain a backwards compatible binding.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v2:
>     - none
>     Changes in v3:
>     - update commit message to indicate backwards incompatible change and
>       why it's OK
>     - retain dfx-server compatible string
> 
>  Documentation/devicetree/bindings/net/marvell,prestera.txt | 13 +++++--------
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi                  | 10 +++-------
>  2 files changed, 8 insertions(+), 15 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
