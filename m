From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 7 Jan 2014 10:15:04 +0200
Subject: [PATCH 0/2] ARM: DTS: am335x-evmsk: Audio and MMC1 fix (for 3.13?)
In-Reply-To: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
References: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <52CBB788.9070404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On 12/23/2013 11:28 AM, Peter Ujfalusi wrote:
> Hi,
> 
> The audio frequency has been incorrectly set in the DTS file which results
> incorrect playback frequency on EVM-SK.
> 
> The SD card can not be used without the second patch on 3.13-rc5.

Can you take a look at these and if it is possible send it for 3.13?

> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   ARM: DTS: am335x-evmsk: Correct audio clock frequency
>   ARM: dts: am335x-evmsk: Fix mmc1 support
> 
>  arch/arm/boot/dts/am335x-evmsk.dts | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 


-- 
P?ter
