From: nm@ti.com (Nishanth Menon)
Date: Wed, 18 Jul 2018 13:04:55 -0500
Subject: [PATCH V2 0/5] arm64: Initial support Texas Instrument's AM654
 Platform
In-Reply-To: <20180626162615.19194-1-nm@ti.com>
References: <20180626162615.19194-1-nm@ti.com>
Message-ID: <20180718180455.gaej4fgf47zytdxk@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:26-20180626, Nishanth Menon wrote:
> Hi,
> 
> This is an minor update from V1 posted earlier:
> 	https://marc.info/?l=linux-kernel&m=152943745424138&w=2
> 
> The following series enables support for newest addition in TI's SoC
> portfolio - AM654 SoC.
> 
> The series is based off v4.18-rc1, also available here:
> https://github.com/nmenon/linux-2.6-playground/tree/upstream/v4.18-rc1/k3-1-am6-base
> 
> Key changes since RFC are indicated in respective patches:
> * Pickedup Tony's Reviewed by
> * Modified cbass nodes to indicate interconnect (patch #3 in the series)

Hi Tony,

Apologies on the off-request. Looks like Tero might be on vacation
and might not be able to send the Pull request to arm-soc folks on time.

Requesting you to pick them up on our behalf for v4.19 if it that is
fine with you. We do have Rob's ack on the bindings themselves, and
the patches also have been reviewed as well.

Patchwork links:
https://patchwork.kernel.org/patch/10527309/
https://patchwork.kernel.org/patch/10489509/
https://patchwork.kernel.org/patch/10489547/
https://patchwork.kernel.org/patch/10489543/
https://patchwork.kernel.org/patch/10489513/

-- 
Regards,
Nishanth Menon
