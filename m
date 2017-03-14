From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 13:58:35 +0100
Subject: [PATCH v2 4/8] ARM: dts: s3c64xx: Enable watchdog on all S3C64xx
 boards
In-Reply-To: <20170311172527.16368-5-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-5-krzk@kernel.org>
 <CGME20170314125837epcas1p481afc11bcf7fc11ef477edda28bccc74@epcas1p4.samsung.com>
Message-ID: <4386279.iJpUOasmTG@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, March 11, 2017 07:25:23 PM Krzysztof Kozlowski wrote:
> Watchdog module does not have external dependencies so it can be safely
> enabled in s3c64xx.dtsi thus making it available for all S3C64xx-based
> boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Please first fix the driver w.r.t. infinite interrupt in soft mode
issue and only then enable it on more hardware.  IOW this patch
should be placed after patch #7 in the series.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
