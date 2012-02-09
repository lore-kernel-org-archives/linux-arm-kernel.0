From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 09 Feb 2012 09:47:22 +0200
Subject: [PATCH v2 0/7] MFD: twl6040: Conversion to i2c driver
In-Reply-To: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <4F337A0A.1010101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/07/2012 03:01 PM, Peter Ujfalusi wrote:
> Still in the to-do list:
> Implement proper regulator support on SDP4430, and PandaBoard for the needed
> supplies by the twl6040.
> The supply source is the same on both boards:
> TWL6040 VDD2V1 <- TWL6030 V2V1 SMPS
> TWL6040 VDDVIO <- TWL6030 V1V8 SMPS
> 
> There seams to be no control implemented in the regulator driver for these SMPS
> regulators, so this need to be done first.
> 
> The reason that I'm sending this series (even when I know that the proper
> regulator support is missing for SDP4430/PandaBoard) is to get feedback for the
> rest of the series, so I can include the fixes in the v3 series.

I will separate the i2c driver conversion, and the regulator support to
avoid bloating this series.
Could you review the first three patch from this series (the i2c driver
conversion part)?
I can as well resend only that as version v3, but I would like to apply
the fixes for the issues you might find before I send it.

Thank you,
P?ter
