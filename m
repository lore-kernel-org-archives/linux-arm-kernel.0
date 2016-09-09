From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 9 Sep 2016 15:43:26 +0200
Subject: [PATCH 3/3] dt-bindings: reset: oxnas: Update for OX820
In-Reply-To: <1473428153.3023.34.camel@pengutronix.de>
References: <20160909131955.27334-1-narmstrong@baylibre.com>
 <20160909131955.27334-4-narmstrong@baylibre.com>
 <1473428153.3023.34.camel@pengutronix.de>
Message-ID: <6045eda4-3a49-555b-9cf8-c321640bc98b@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 09/09/2016 03:35 PM, Philipp Zabel wrote:
> Hi Neil,
> 
> Am Freitag, den 09.09.2016, 15:19 +0200 schrieb Neil Armstrong:
>> Add new compatible string for reset and sys-ctrl for the Oxford
>> Semiconductor OX820 Support.
>> Drop the OX810SE indices since they moved in a dedicated include file.
> 
> Not sure if the OX820 reset controller should be considered "compatible"
> to OX810SE. The register layout and usage is the same, but the reset
> indices are different. Does this warrant a new compatible string, or
> should this be
> 	compatible = "oxsemi,ox820-reset", "oxsemi,ox810se-reset"?

As indicated on the cover letter, I'll like to have each supported SoC
as a specific compatible, to ease maintaining the drivers and
clarify what HW is supported.

Having an include file per SoC is also part of the process.

> 
[...]
> 
> Please add a pointer to include/dt-bindings/reset/oxsemi,ox8{10se,20}.h

OK, will do in v2.

> 
> Otherwise I'm fine with the series, pending DT maintainer approval.
> 
> regards
> Philipp
> 

Thanks,
Neil
