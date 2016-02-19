From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 11:17:53 +0100
Subject: [PATCH 1/9] ARM: ARMv7-M uses BE-8, not BE-32
In-Reply-To: <56C6D6B3.60605@arm.com>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <2702301.CTWUiSsjZR@wuerfel> <56C6D6B3.60605@arm.com>
Message-ID: <4528627.ddzfcWQ79X@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 February 2016 08:47:47 Vladimir Murzin wrote:
> Ah, it explains why my quick attempt to enable BE for MPS2 (M-class
> platform) failed. With this patch applied I'm able to see Linux booting
> on MPS2 FVP model in BE, not complete boot but it might be due to other
> reasons. So this patch definitely improves things for me, if it helps
> 
> Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
> 

Awesome, thanks for testing!

	Arnd
