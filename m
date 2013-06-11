From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 11 Jun 2013 09:47:36 +0200
Subject: OMAP v3.10-rc regressions that no one's fixed
In-Reply-To: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com>
Message-ID: <51B6D618.30809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 06/10/2013 09:22 AM, Paul Walmsley wrote:
> 
> Hi folks -- particularly TIers working on mainline,
> 
> There are several regressions that started with v3.10-rc that no one's 
> fixed for over a month.  Some of them should be quite easy:
> 
> * 2430SDP, 3730 Beagle XM, 3530 Beagle, 3517EVM, CM-T3517: {dmic,mcpdm} lookup failure
>   - Cause unknown
>   - These IP blocks don't exist on OMAP3xxx/AM35xx chips

I will send a patch soon to fix these. Need to test the patch(es) first. I
think they surfaced because I have enabled the audio support in
omap2plus_defconfig for OMAP4 and 5 - which require McPDM and DMIC.
Just couple of minutes, and I'll have the fix.

-- 
P?ter
