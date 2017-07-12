From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jul 2017 02:26:16 -0700
Subject: [RESEND PATCH] bus: omap-ocp2scp: Fix error handling in
 omap_ocp2scp_probe
In-Reply-To: <20170711101638.2233-1-kishon@ti.com>
References: <20170711101638.2233-1-kishon@ti.com>
Message-ID: <20170712092616.GC16509@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170711 03:17]:
> The error handling code in omap_ocp2scp_probe fails to invoke
> pm_runtime_disable and fails to initialize return value in
> certain cases. Fix it here.

Applying into omap-for-v4.13/fixes thanks.

Tony
