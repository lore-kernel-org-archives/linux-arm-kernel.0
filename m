From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 25 Oct 2016 16:25:57 +0530
Subject: [PATCH/RFT v2 00/17] Add DT support for ohci-da8xx
In-Reply-To: <20161024164634.4330-1-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
Message-ID: <39744873-14ec-5eae-640c-10435b9eb492@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> The purpose of this patch series is to add DT support and modernize
> the ohci-da8xx glue driver without breaking the non-DT boot,
> which is still used in unconverted davinci devices.

>From a mach-davinci perspective, there are some patches which seem to be
safe to apply and some which depend on corresponding driver changes to
get in.

In order to speed up the process of applying this series, can you split
the mach-davinci updates which are safe to apply into a separate series.

For DT patches, the bindings should be accepted. For other patches, they
should not be causing any regressions.

Thanks,
Sekhar
