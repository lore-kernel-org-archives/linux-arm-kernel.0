From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 12 Jun 2017 11:32:37 +0300
Subject: [PATCH 0/6] Init Clock frequences for accelerators
In-Reply-To: <20170612073635.GT3730@atomide.com>
References: <20170607212730.33002-1-s-anna@ti.com>
 <20170612073635.GT3730@atomide.com>
Message-ID: <ea1b56dd-1a91-42a1-6247-2acd0dcc1dab@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/17 10:36, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [170607 14:31]:
>> Hi Tony,
>>
>> The following series configures the initial frequencies for the required
>> DPLLs and corresponding output divider clocks used by various remoteproc
>> accelerators (DSP, IVAHD) on OMAP4, OMAP5 & DRA7xx/AM57xx SoCs and the
>> GPU on DRA7xx/AM57xx SoCs. All these devices require Adaptive Voltage
>> Scaling (AVS) to be programmed at all OPPs at boot time, which is
>> programmed in the bootloader. Furthermore, DVFS is not supported on
>> these domains implying a one-time OPP clock frequency setup.
> 
> Tero, care to comment or ack this series?

These have been in use in TI releases for quite a while already, and 
look fine, thus:

Acked-by: Tero Kristo <t-kristo@ti.com>

(Didn't quite think my ack was needed for them so didn't respond 
earlier, sorry.)
