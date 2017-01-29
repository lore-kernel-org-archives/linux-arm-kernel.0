From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 29 Jan 2017 17:22:55 +0100
Subject: [PATCH v2 08/25] dt-bindings: power: supply: add AXP20X/AXP22X
 AC power supply
In-Reply-To: <20170127085458.18270-9-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-9-quentin.schulz@free-electrons.com>
Message-ID: <20170129162255.if2o2ta4wt2vetad@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 27, 2017 at 09:54:41AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs have an AC entry to supply power to
> the board. They have a few registers dedicated to the status of the AC
> power supply.
> 
> This adds the DT binding documentation for the AC power supply for
> AXP20X and AXP22X PMICs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Thanks, I queued this into power-supply's for-next branch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170129/1ab05834/attachment-0001.sig>
