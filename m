From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 8 Aug 2016 16:21:13 +0530
Subject: [PATCH v2] ARM: dts: da850: Add new ECAP and EPWM bindings
In-Reply-To: <1468264306-3806-1-git-send-email-fcooper@ti.com>
References: <1468264306-3806-1-git-send-email-fcooper@ti.com>
Message-ID: <57A86421.6030804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 July 2016 12:41 AM, Franklin S Cooper Jr wrote:
> From: "Cooper Jr., Franklin" <fcooper@ti.com>
> 
> For some devices, the PWMSS is a parent of eCAP and ePWM and provided the

"and provides .."

> functional clocks for those submodules. The ti,am33xx-ecap and
> ti,am33xx-ehrpwm were based on this parent child relationship where the

"ti,am33xx-ehrpwm bindings were .."

> functional clock would be grabbed from the module's parent.
> 
> However, DA850 doesn't have a PWMSS and the eCAP and ePWM provides their
> functional clock themselves. Therefore, prefer the new binding that doesn't
> assume this parent child relationship.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>

Queuing this for v4.9 with above minor commit message fixes made locally.

Regards,
Sekhar
