From: horms@verge.net.au (Simon Horman)
Date: Thu, 11 May 2017 17:48:31 +0200
Subject: [PATCH/RFT 0/2] ARM: dts: gose: Enable UHS-I SDR-50 and SDR-104
In-Reply-To: <1492494939-24568-1-git-send-email-horms+renesas@verge.net.au>
References: <1492494939-24568-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20170511154831.GI21895@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 02:55:37PM +0900, Simon Horman wrote:
> Enable
> - SDR-50 and SDR-104 for SDHI0 and;
> - SDR-50 for SDHI1
> 
> Verified:
> - SDR104 for SDHI0
> - SDR50 for SDHI1
> - Results comprable to those listed for other Renesas R-Car Gen2 boards on
>   http://elinux.org/Tests:SD-SDHI-SDR104
> Untested:
> SDR50 for SDHI3
> - HS C4 card present in slot on board which I access remotely

The above should read SDHI2 rather than SDHI3.
I have now been able to test SDHI2 and have queued up this series
with Wolfram's Acks.

> Simon Horman (2):
>   ARM: dts: r8a7793: set maximum frequency for SDHI clocks
>   ARM: dts: gose: Enable UHS-I SDR-50 and SDR-104
> 
>  arch/arm/boot/dts/r8a7793-gose.dts | 34 +++++++++++++++++++++++++++++++---
>  arch/arm/boot/dts/r8a7793.dtsi     |  3 +++
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> -- 
> 2.7.0.rc3.207.g0ac5344
> 
