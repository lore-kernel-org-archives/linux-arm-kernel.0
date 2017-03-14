From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 14:20:21 +0100
Subject: [PATCH v3 3/3] watchdog: s3c2410: Minor code cleanup
In-Reply-To: <20170313190726.2988-4-krzk@kernel.org>
References: <20170313190726.2988-1-krzk@kernel.org>
 <20170313190726.2988-4-krzk@kernel.org>
 <CGME20170314132022epcas1p26da7dbe4da6d77ebfc1a8e045ee370de@epcas1p2.samsung.com>
Message-ID: <1563377.9eIcBQftln@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 13, 2017 09:07:26 PM Krzysztof Kozlowski wrote:
> Cleanup the code from minor readability issues (no functional changes):
> 1. Fix checkpatch: ERROR: Do not include the paragraph about writing to
>    the Free Software Foundation's mailing address.
> 2. Fix checkpatch: WARNING: quoted string split across lines
> 3. Fix chechpatch: WARNING: Prefer 'unsigned int' to bare use of
>    'unsigned'
> 4. Use 'dev' consistently in probe function instead of mixing dev with
>    &pdev->dev.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
