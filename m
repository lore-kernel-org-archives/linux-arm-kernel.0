From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 14:11:55 +0100
Subject: [PATCH v3 1/3] watchdog: s3c2410: Constify local structures
In-Reply-To: <20170313190726.2988-2-krzk@kernel.org>
References: <20170313190726.2988-1-krzk@kernel.org>
 <20170313190726.2988-2-krzk@kernel.org>
 <CGME20170314131158epcas5p3ca1212cc3ce89b0666cafc3aaa87fb78@epcas5p3.samsung.com>
Message-ID: <1630264.smGZ3BB1uD@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 13, 2017 09:07:24 PM Krzysztof Kozlowski wrote:
> Structures watchdog_device, watchdog_ops and s3c2410_wdt_variant are not
> modified so they can be made const to increase code safeness.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
