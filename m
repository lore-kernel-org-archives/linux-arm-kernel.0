From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 29 Jan 2017 17:25:37 +0100
Subject: [PATCH v2 10/25] power: supply: add AC power supply driver for
 AXP20X and AXP22X PMICs
In-Reply-To: <20170127085458.18270-11-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-11-quentin.schulz@free-electrons.com>
Message-ID: <20170129162537.npe25eklgml3m25s@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 27, 2017 at 09:54:43AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
> supply.
> 
> Moreover, the AXP20X can also expose the current current and voltage
> values of the AC power supply.
> 
> This adds the driver which exposes the status of the AC power supply of
> the AXP20X and AXP22X PMICs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks, I queued this into power-supply's for-next branch. I
removed "struct device_node *np" and "int axp20x_id" from
"struct axp20x_ac_power", since they were unused.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170129/23e6f0db/attachment.sig>
