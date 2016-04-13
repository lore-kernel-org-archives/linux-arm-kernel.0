From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Apr 2016 10:35:19 -0700
Subject: [PATCH 0/4] Few more updates for NS2 DT
In-Reply-To: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
References: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <570E8357.4000303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/03/16 00:27, Anup Patel wrote:
> This patchset primarily adds more PL330 and PL022 DT nodes for
> NS2 SVK. It also moves clock DT nodes to separate file to be
> consistent with other Broadcom SoCs DT files.
> 
> The patchset is based on v4.6-rc1 tag and is available in ns2_dt3_v1
> branch of https://github.com/Broadcom/arm64-linux.git
> 
> All patches have been tested on Broadcom NS2 SVK.
> 
> Anup Patel (4):
>   arm64: dts: Add ARM PL330 DMA DT node for NS2
>   arm64: dts: Add maintenance interrupt for GIC in NS2 DT
>   arm64: dts: Move NS2 clock DT nodes to separate DT file
>   arm64: dts: Add ARM PL022 SPI DT nodes for NS2

Series applied to devicetree-arm64/next, thanks!
-- 
Florian
