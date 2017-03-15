From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 15 Mar 2017 23:24:49 +0100
Subject: [PATCH v4 02/18] power: supply: power_supply_core: add
 constant-charge-current optional property
In-Reply-To: <20170315105537.22349-3-quentin.schulz@free-electrons.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-3-quentin.schulz@free-electrons.com>
Message-ID: <20170315222449.bvca6r3zoaxoedlb@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 15, 2017 at 11:55:21AM +0100, Quentin Schulz wrote:
> This adds the constant-charge-current property to the list of optional
> properties for the battery.
> 
> The constant charge current is critical for batteries as they can't
> handle all charge currents.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/fb9be2c2/attachment.sig>
