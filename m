From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 02 Nov 2015 10:45:57 -0800
Subject: [PATCH RESEND v4 0/2] ARM: dts: bcm5301x: Add SVK DT files and
 docs
In-Reply-To: <1446489293-25088-1-git-send-email-jonmason@broadcom.com>
References: <1446489293-25088-1-git-send-email-jonmason@broadcom.com>
Message-ID: <5637AF65.5020905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/15 10:34, Jon Mason wrote:
> Resending due to lack of any response to the original v4 series
> 
> Changes in v4:
> * Changed bootargs to stdout-path, per Sudeep Holla
> 
> Changes in v3:
> * Updated the DT documentation compat strings
> * Modified the include files and compat strings for the SVK DT files,
>   per Hauke Mehrtens
> 
> Changes in v2:
> * Reorder the patches to add the DT binding documentation prior to the
>   new DT files
> * Removed the DT documentation compat strings to only the SoCs, not the
>   individual boards
> * Fixed the compat strings in the individual device tree files
> * Added the memory node and removed the "mem=" from the bootargs

Series applied to devicetree/next, thanks Jon!
-- 
Florian
