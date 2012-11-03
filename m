From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 3 Nov 2012 21:46:46 +0530
Subject: [PATCH 06/15] ARM: OMAP2+: hwmod: Enable OCMCRAM registration
 in AM33XX
In-Reply-To: <1351859566-24818-7-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-7-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <5095436E.6030206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> The hwmod data for OCMCRAM in AM33XX was commented out.
> This data is needed by the power management code, hence
> uncomment the same and register the OCP interface for it.
>
Why this data is needed by PM code ?

Regards
Santosh
