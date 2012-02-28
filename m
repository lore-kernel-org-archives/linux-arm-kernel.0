From: khilman@ti.com (Kevin Hilman)
Date: Tue, 28 Feb 2012 14:37:04 -0800
Subject: [PATCH 01/14] ARM: OMAP3+: SmartReflex: Layer Cleanup [V4]
In-Reply-To: <1328723039-15952-2-git-send-email-j-pihet@ti.com> (Jean Pihet's
 message of "Wed, 8 Feb 2012 18:43:46 +0100")
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
 <1328723039-15952-2-git-send-email-j-pihet@ti.com>
Message-ID: <87ipiqk2jz.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> From: Shweta Gulati <shweta.gulati@ti.com>
>
> To set sr ntarget values for all volt_domain,
> volt_table is retrieved by doing a look_up of 'vdd_name'
> field from omap_hwmod but voltage domain pointer does not
> belong to omap_hwmod and is not used anywhere else.
> As a part of voltage layer and SR Layer clean up volt
> pointer is removed from omap_hwmod and added in dev
> attributes of SR.
>
> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>
> [nm at ti.com: minor modifications in sequence and GPU support]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Acked by: Nishanth Menon <nm@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Patch contents look fine, but his one needs a better subject.

Kevin
