From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 7 Aug 2017 10:30:37 -0700
Subject: [PATCH 0/7] Add more DT nodes for Stingray SoC
In-Reply-To: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
References: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
Message-ID: <77f099ec-5cbe-b2c9-241a-c00ea63ee3ae@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2017 09:42 PM, Abhishek Shah wrote:
> This is round two of adding DT nodes for Stingray SoC.
> Corresponding drivers and dt binding documents are already
> checked in the kernel and will be present in v4.14.
> 
> Abhishek Shah (1):
>   arm64: dts: Add DT node to enable BGMAC driver on Stingray
> 
> Anup Patel (3):
>   arm64: dts: Add sp804 DT nodes for Stingray SoC
>   arm64: dts: Add FlexRM DT nodes for Stingray
>   arm64: dts: Add SBA-RAID DT nodes for Stingray SoC
> 
> Srinath Mannam (2):
>   arm64: dts: Add MDIO multiplexer DT node for Stingray
>   arm64: dts: Add SATA DT nodes for Stingray SoC
> 
> Velibor Markovski (1):
>   arm64: dts: Enable stats for CCN-502 interconnect on Stingray

Series applied, thanks
-- 
Florian
