From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Dec 2014 19:33:57 +0000
Subject: [PATCH v5 0/2] poweroff-source DT property renaming
In-Reply-To: <1416918506-9366-1-git-send-email-romain.perier@gmail.com>
References: <1416918506-9366-1-git-send-email-romain.perier@gmail.com>
Message-ID: <20141201193357.GO7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 12:28:24PM +0000, Romain Perier wrote:
> The goal of this serie is to rename the property "poweroff-source" to
> "system-power-controller". After discussions, it makes more sense to rename back
> to the old established property name. This patches serie reverts
> commit a4b4e0461ec5 ("of: Add standard property for poweroff capability").

> Changes since v4:
>   - Renamed the helper function to of_device_is_system_power_controller

Applied both, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/ebc6c27c/attachment.sig>
