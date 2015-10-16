From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Oct 2015 14:06:33 +0100
Subject: [RFC 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1444997709-57293-2-git-send-email-ck.hu@mediatek.com>
References: <1444997709-57293-1-git-send-email-ck.hu@mediatek.com>
 <1444997709-57293-2-git-send-email-ck.hu@mediatek.com>
Message-ID: <20151016130632.GE2054@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	/* FIXME - use of_graph_get_port_by_id(np, 1) on newer kernels */
> +	in_ep = of_graph_get_next_endpoint(np, NULL);

Huh?

> +	edidp = of_get_property(np, "edid", &size);

This property wasn't mentioned in the binding document.

Please describe it. If it's from a more generic binding, refer to that
from the binding document.

Thanks,
Mark.
