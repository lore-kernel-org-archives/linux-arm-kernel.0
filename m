From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 29 Nov 2013 13:59:47 +0530
Subject: [PATCH] ARM: davinci: Fix McASP mem resource names
In-Reply-To: <1384354097-1163-1-git-send-email-peter.ujfalusi@ti.com>
References: <1384354097-1163-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <5298507B.5050102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

On Wednesday 13 November 2013 08:18 PM, Peter Ujfalusi wrote:
> The ASoC McASP driver looks for the mem resources by name and:
> "mpu" and "dat" regions.
> Change/add the needed name for the mem resources so the driver can pick the
> correct resource.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks for the patch. It does make the soundcard detect again on
DaVinci. Will queue for v3.13-rc3 (too late for -rc2, sorry!)

Thanks,
Sekhar
