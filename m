From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Nov 2016 15:03:47 +0530
Subject: [PATCH 0/2] ARM: davinvi: da850 add ohci DT nodes
In-Reply-To: <20161121165920.29809-1-ahaslam@baylibre.com>
References: <20161121165920.29809-1-ahaslam@baylibre.com>
Message-ID: <3543ab96-1a7e-395f-26a6-c748cf0423f1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2016 10:29 PM, Axel Haslam wrote:
> This adds the DT node for the ohci controller and
> enables it for the omapl138-lckd platform.
> 
> DEPENDENCIES:
> 
> 1. [PATCH v6 0/5] USB: ohci-da8xx: Add device tree support
> https://lkml.org/lkml/2016/11/21/558

Looks like atleast this series is not merged (checking today's linux-next).

> 
> 2. [PATCH v3 0/2] regulator: handling of error conditions for usb drivers
> https://lkml.org/lkml/2016/11/4/465

Can you let me know once the dependencies are merged so I can pick these.

Thanks,
Sekhar
