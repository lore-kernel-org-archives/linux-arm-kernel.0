From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 12:37:17 -0400
Subject: [PATCH 3/3] ARM: kirkwood: Move the nand node under the mbus node
In-Reply-To: <20130917184433.GF21230@obsidianresearch.com>
References: <20130917184433.GF21230@obsidianresearch.com>
Message-ID: <20131001163717.GB31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 12:44:33PM -0600, Jason Gunthorpe wrote:
> There should be no nodes that are not children of the mbus. Move
> the nand node under the mbus, and rework the board .dts files
> to use an & reference to the nand node.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/arm/boot/dts/kirkwood-db.dtsi                 | 44 +++++------
>  arch/arm/boot/dts/kirkwood-dnskw.dtsi              | 76 +++++++++----------
>  arch/arm/boot/dts/kirkwood-dockstar.dts            | 40 +++++-----
>  arch/arm/boot/dts/kirkwood-goflexnet.dts           | 51 ++++++-------
>  .../arm/boot/dts/kirkwood-guruplug-server-plus.dts | 40 +++++-----
>  arch/arm/boot/dts/kirkwood-ib62x0.dts              | 44 +++++------
>  arch/arm/boot/dts/kirkwood-iconnect.dts            | 58 +++++++--------
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      | 51 ++++++-------
>  arch/arm/boot/dts/kirkwood-km_kirkwood.dts         | 14 ++--
>  arch/arm/boot/dts/kirkwood-mplcec4.dts             | 62 ++++++++--------
>  .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 60 +++++++--------
>  arch/arm/boot/dts/kirkwood-nsa310-common.dtsi      | 86 +++++++++++-----------
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts       | 74 +++++++++----------
>  arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  | 42 +++++------
>  arch/arm/boot/dts/kirkwood-topkick.dts             | 62 ++++++++--------
>  arch/arm/boot/dts/kirkwood.dtsi                    | 31 ++++----
>  16 files changed, 418 insertions(+), 417 deletions(-)

Applied to mvebu/dt with Ezequiel's Ack and Tested-by.

thx,

Jason.
