From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 13 Apr 2012 05:20:29 -0600 (MDT)
Subject: [PATCH 1/2] ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE
 flag from VENC slave interface
In-Reply-To: <1334304116-18872-2-git-send-email-archit@ti.com>
References: <1334304116-18872-1-git-send-email-archit@ti.com>
 <1334304116-18872-2-git-send-email-archit@ti.com>
Message-ID: <alpine.DEB.2.00.1204130520170.25832@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Apr 2012, Archit Taneja wrote:

> The clocks for all DSS slave interfaces were recently changed to "dss_ick" on
> OMAP2 and OMAP3, this clock can be autoidled by PRCM. The VENC interface
> previously had "dss_54m_fck" as it's clock which couldn't be autoidled, and
> hence the OCPIF_SWSUP_IDLE flag was needed.
> 
> Remove the OCPIF_SWSUP_IDLE flag from VENC interfaces as it's clock is now
> "dss_ick".
> 
> Signed-off-by: Archit Taneja <archit@ti.com>

Thanks, queued for 3.4-rc.


- Paul
