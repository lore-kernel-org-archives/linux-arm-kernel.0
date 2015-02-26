From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Feb 2015 13:53:23 +0800
Subject: [PATCH v2] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <1424907152-18808-1-git-send-email-mathieu.poirier@linaro.org>
References: <1424907152-18808-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20150226055320.GA20385@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 04:32:32PM -0700, Mathieu Poirier wrote:
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
> new file mode 100644
> index 000000000000..3ddb676831ab
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
> @@ -0,0 +1,62 @@
> +What:		/sys/bus/coresight/devices/<memory_map>.stm/enable_source
> +Date:		February 2015
> +KernelVersion:	3.20

A random comment - there will never be a v3.20 kernel.

Shawn

> +Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
> +Description:	(RW) Enable/disable tracing on this specific trace macrocell.
> +		Enabling the trace macrocell implies it has been configured
> +		properly and a sink has been identidifed for it.  The path
> +		of coresight components linking the source to the sink is
> +		configured and managed automatically by the coresight framework.
