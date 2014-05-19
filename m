From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 19 May 2014 18:32:02 +0530
Subject: [PATCH v3 05/13] ARM/platform_data: edma: Remove queue_tc_mapping
 data from edma_soc_info
In-Reply-To: <1400242640-9902-6-git-send-email-peter.ujfalusi@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
 <1400242640-9902-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <537A00CA.2060009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 May 2014 05:47 PM, Peter Ujfalusi wrote:
> It is no longer in use by the driver or board files.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I dropped the /platform_data in subject like to keep it consistent with
what has been done for this file so far. Even looking at logs for other
files in this directory there is no such convention.

Same thing for 13/13.

Thanks,
Sekhar
