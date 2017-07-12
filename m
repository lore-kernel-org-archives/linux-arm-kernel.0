From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 12 Jul 2017 16:27:34 +0530
Subject: [RESEND PATCH] bus: omap-ocp2scp: Fix error handling in
 omap_ocp2scp_probe
In-Reply-To: <20170712092616.GC16509@atomide.com>
References: <20170711101638.2233-1-kishon@ti.com>
 <20170712092616.GC16509@atomide.com>
Message-ID: <7291e53a-cc06-0056-9f50-50d3c35fba31@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 12 July 2017 02:56 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170711 03:17]:
>> The error handling code in omap_ocp2scp_probe fails to invoke
>> pm_runtime_disable and fails to initialize return value in
>> certain cases. Fix it here.
> 
> Applying into omap-for-v4.13/fixes thanks.

Thanks!

-Kishon
