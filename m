From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 20 Feb 2016 11:50:38 -0800
Subject: [PATCH v2 0/5] Support for Broadcom Vulcan ARM64 processor
In-Reply-To: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
References: <1455977964-8099-1-git-send-email-jchandra@broadcom.com>
Message-ID: <56C8C38E.50007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/02/2016 06:19, Jayachandran C a ?crit :
> This patchset adds support for Broadcom's Vulcan ARM64 processor.
> The changes are to add the device tree files, documentation for the
> device tree, cpu ID and the maintainers entry.
> 
> This is v2 of the patchset, changelog below:
> 
> v1->v2 :
>  - dts: remove memreserve, use brcm,vulcan-soc for board
>    (to address comments from Mark Rutland)
>  - Fixup copyright (Broadcomp corp -> Broadcom)
>    (suggested by Florian Fainelli)
>  - Rename dts from brcm-vulcan* to vulcan*
>    (suggested by Ray Jui)
>  - Add maintainers entry
>    (suggested by Florian Fainelli)
>  - Updated the device tree doc and fixed a couple of commit
>    comments
> 
> Jayachandran C (4):
>   dt-bindings: Add documentation for Broadcom Vulcan
>   arm64: defconfig: Add Broadcom Vulcan to defconfig
>   arm64: cputype info for Broadcom Vulcan
>   MAINTAINERS: Add entry for Broadcom Vulcan SoC
> 
> Zi Shen Lim (1):
>   arm64: Broadcom Vulcan support

All applied and submitted for 4.6 thanks!
-- 
Florian
