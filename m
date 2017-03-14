From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 14:17:06 +0100
Subject: [PATCH v3 2/3] watchdog: s3c2410: Simplify getting driver data
In-Reply-To: <20170313190726.2988-3-krzk@kernel.org>
References: <20170313190726.2988-1-krzk@kernel.org>
 <20170313190726.2988-3-krzk@kernel.org>
 <CGME20170314131709epcas5p4e150e0df2a04a3369edf61b2075e2e8f@epcas5p4.samsung.com>
Message-ID: <2568764.DQnxL2m83S@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, March 13, 2017 09:07:25 PM Krzysztof Kozlowski wrote:
> Simplify the flow in helper function for getting the driver data by
> using of_device_get_match_data() and only one if() branch.
> 
> The code should be equivalent.

While you are at it could you remove s3c2410_get_wdt_drv_data()
helper?  It is used only once during probe and is marked inline
anyway..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
