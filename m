From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 6 Jun 2016 11:53:25 -0700
Subject: [PATCH v2 0/6] Support BCM23550 SoC
In-Reply-To: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
Message-ID: <5755C6A5.1040202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2016 02:36 PM, Chris Brand wrote:
> This patchset introduces support for the BCM23550 SoC and the Broadcom
> Sparrow development board.
> 
> It modifies the BCM21664 support slightly to share code between the two.
> 
> With this patchset, a multi-v7 kernel brings up all 4 CPUs on a Sparrow
> board, and gets to a shell prompt. Many of the IP blocks that are shared
> with BCM28155 and BCM21664 are also functional, although not all have
> been thoroughly tested.
> 
> Changes since v1
> - Moved chosen node from dtsi to dts file
> - Added stdout-path property to chosen node in dts
> - Removed "-cpu-method" from CPU enable method name

Series applied, patch 1 applied to drivers/next, patches 2, 4 and 5
applied to soc/next, and patches 2 and 6 applied to devicetree/next,
thanks everyone!
-- 
Florian
