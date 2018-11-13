From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Tue, 13 Nov 2018 12:34:14 +0200
Subject: [PATCH 1/5] dt-bindings: media: Add Allwinner A10 CSI binding
In-Reply-To: <60494dd4245ab01473d074dc5cd46198a2181614.1542097288.git-series.maxime.ripard@bootlin.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <60494dd4245ab01473d074dc5cd46198a2181614.1542097288.git-series.maxime.ripard@bootlin.com>
Message-ID: <20181113103413.imvwqplpxdhqeag3@kekkonen.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, Nov 13, 2018 at 09:24:13AM +0100, Maxime Ripard wrote:
> The Allwinner A10 CMOS Sensor Interface is a camera capture interface also
...
> +Optional properties:
> +  - allwinner,csi-channels: Number of channels available in the CSI
> +                            controller. If not present, the default
> +                            will be 1.

Is this virtual channels or something else btw.?

-- 
Sakari Ailus
sakari.ailus at linux.intel.com
