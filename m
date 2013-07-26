From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 26 Jul 2013 15:26:06 +0530
Subject: XCLKOUT in exynos5250 clock driver
In-Reply-To: <20130725145158.GI9858@sirena.org.uk>
References: <20130725145158.GI9858@sirena.org.uk>
Message-ID: <51F247B6.9010902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2013 08:21 PM, Mark Brown wrote:
> I appear to be missing something in the clock driver for the exynos5250.
> I'm looking at the Arndale schematic and I see that the audio master
> clock is connected to XCLKOUT on the SoC.  However I can't see any
> reference to XCLKOUT or anything similar in the clock driver or any of
> the DTS files - where is this clock exposed by the clock driver?
> 
> Unfortunately I haven't been able to get access to the datasheet for the
> part so I can't check this myself.
> 

Information as per Exynos5250 user manual:
"XCLKOUT is an output pin for debugging clocks. Exynos5250 has a CLKOUT
logic which can select one of the clocks (within its clock domains) and
output that through XCLKOUT pin."

Not sure if XCLKOUT on Arndale schematics means the same.

-- 
Tushar Behera
